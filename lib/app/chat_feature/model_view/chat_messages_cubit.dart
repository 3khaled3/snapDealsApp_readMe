import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/core/utils/network_utils.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_config.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_room.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_model.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_status.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_type.dart';
import 'package:snap_deals/app/chat_feature/data/models/uploading_message.dart';
import 'package:snap_deals/app/chat_feature/data/repositories/chat_room_repository.dart';
import 'package:snap_deals/app/chat_feature/data/services/chat_service.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class ChatMessagesCubit extends Cubit<List<MessageModel>> {
  late Box<MessageModel> _messageBox;
  final List<MessageModel> fieldMessages = [];
  final List<UploadingMessage> _failedAttachmentUploads = [];
  ChatRoom chatRoom;
  final Partner partner;
  final ChatConfig chatConfig;
  late DatabaseReference dbRef;
  StreamSubscription<QuerySnapshot>? _messagesSubscription;
  late final VoidCallback _onBoxChange;
  late String chatRoomId;
  late ChatService chatService;

  ChatMessagesCubit({
    required this.chatRoom,
    required this.partner,
    required this.chatConfig,
  }) : super([]) {
    chatService = ChatService(chatConfig: chatConfig);
    chatRoomId = chatRoom.id;
    dbRef = FirebaseDatabase.instance
        .ref()
        .child(chatConfig.chatMessagesCollection)
        .child(chatRoomId);
    print('object ${chatRoom.id}');
    _initHive().then((_) {
      _listenToMessages(chatRoomId);
      listenForConnectivityChanges();
    });
  }

  void listenForConnectivityChanges() {
    FirebaseUtils.onConnectivityChanged.listen((connectivityResult) async {
      if (connectivityResult.isNotEmpty &&
          connectivityResult
              .any((result) => result != ConnectivityResult.none)) {
        // Retry failed regular messages
        if (fieldMessages.isNotEmpty) {
          List<Future> futures = [];
          for (var message in fieldMessages) {
            final updatedMessage = message.copyWith(
                status: MessageStatus.sent,
                timestamp: DateTime.now().millisecondsSinceEpoch);

            final future = chatService.sendMassageToFireStore(
                partner: partner,
                chatRoomId: chatRoomId,
                updatedMessage: updatedMessage);
            final future2 = _messageBox.put(message.id, updatedMessage);

            futures.add(future);
            futures.add(future2);
          }
          await Future.wait(futures);
          try {
            await chatService.updateChatRoomWithLastMessage(
                currentChatRoom: chatRoom, message: fieldMessages.last);
          } catch (e) {
            print("😭😭😭😭😭😭😭Error updating chat room: $e");
          }
          fieldMessages.clear();
        }

        // Retry failed attachment uploads
        if (_failedAttachmentUploads.isNotEmpty) {
          List<Future> futures = [];
          for (var attachment in _failedAttachmentUploads) {
            final updatedMessage = attachment.copyWith(
                timestamp: DateTime.now().millisecondsSinceEpoch);
            final future = uploadAttachment(updatedMessage);
            futures.add(future);
          }
          await Future.wait(futures);
          _failedAttachmentUploads.clear();
        }
      } else {
        print("You are offline.");
      }
    });
  }

  // Initialize Hive and listen for changes
  Future<void> _initHive() async {
    if (!Hive.isBoxOpen(chatConfig.chatMessagesCollection)) {
      _messageBox =
          await Hive.openBox<MessageModel>(chatConfig.chatMessagesCollection);
    } else {
      _messageBox = Hive.box<MessageModel>(chatConfig.chatMessagesCollection);
    }
    _onBoxChange = () => loadCachedMessages();
    final failedMessages = _messageBox.values
        .where((e) => e.chatRoomId == chatRoom.id)
        .toList()
        .where((e) =>
            e.status == MessageStatus.failed && e.type == MessageType.text);
    fieldMessages.addAll(failedMessages);
    final failedAttachmentUploads = _messageBox.values
        .where((e) => e.chatRoomId == chatRoom.id)
        .toList()
        .where((e) =>
            e.status == MessageStatus.failed && e.type != MessageType.text);

    _failedAttachmentUploads.addAll(
      failedAttachmentUploads.map((e) => UploadingMessage(
            id: e.id,
            chatRoomId: e.chatRoomId,
            senderId: e.senderId,
            content: e.content,
            timestamp: e.timestamp,
            type: e.type,
            status: e.status,
            replyToMessageId: e.replyToMessageId,
            progress: "0",
          )),
    );

    _messageBox.listenable().addListener(_onBoxChange);
    loadCachedMessages();
  }

  // Load cached messages from Hive
  void loadCachedMessages() {
    if (isClosed) return;

    try {
      final cachedMessages = _messageBox.values
          .where((e) => e.chatRoomId == chatRoom.id)
          .toList()
          .reversed
          .toList();
      emit(cachedMessages);
    } catch (e) {
      print("😭😭😭😭😭😭Error loading cached messages: $e");
    }
  }

  // Listen to Firestore for real-time messages
  void _listenToMessages(String chatRoomId) {
    chatService.updateChatRoomUnReadCounter(chatRoomId: chatRoomId);
    dbRef.onChildAdded.listen((event) async {
      if (event.snapshot.value != null) {
        final safeMap = deepConvert(event.snapshot.value);
        final message = MessageModel.fromMap(safeMap);

        // Store message in Hive for local cache
        await _messageBox.put(message.id, message);
      }
    }, onError: (error) {
      print("😭 Error fetching messages from Realtime Database: $error");
    });
    dbRef.onChildChanged.listen((event) async {
      if (event.snapshot.value != null) {
        final safeMap = deepConvert(event.snapshot.value);
        final message = MessageModel.fromMap(safeMap);

        // Store message in Hive for local cache
        await _messageBox.put(message.id, message);
      }
    }, onError: (error) {
      print("😭 Error fetching messages from Realtime Database: $error");
    });
  }

  // Send a new message
  Future<void> sendMessage(MessageModel message) async {
    await firstMessage(chatRoom, _messageBox, chatConfig);

    try {
      // Cache the message in Hive
      await _messageBox.put(message.id, message);
      final isOnline = await FirebaseUtils.isOnline();
      if (isOnline) {
        final updatedMessage = message.copyWith(status: MessageStatus.sent);
        print(" updatedMessage:Send 😁😁😁😁😁😁😁😁😁😁😁");
        // Send the message to Firestore
        await chatService.sendMassageToFireStore(
            partner: partner,
            chatRoomId: chatRoomId,
            updatedMessage: updatedMessage);
        print(" updatedMessage:Send 😁😁😁😁😁😁😁😁😁😁😁2");
        // Update the chat room with the last message
        try {
          await chatService.updateChatRoomWithLastMessage(
              currentChatRoom: chatRoom, message: message);
          print(" updatedMessage:Send 😁😁😁😁😁😁😁😁😁😁😁3");
        } catch (e) {
          print("😭😭😭😭😭😭😭Error updating chat room: $e");
        }
      } else {
        final updatedMessage = message.copyWith(status: MessageStatus.failed);
        await _messageBox.put(updatedMessage.id, updatedMessage);
        fieldMessages.add(updatedMessage);
      }
    } catch (e) {
      final updatedMessage = message.copyWith(status: MessageStatus.failed);
      await _messageBox.put(updatedMessage.id, updatedMessage);
      fieldMessages.add(updatedMessage);

      print("😭😭😭😭😭😭Error sending message: $e");
    }
  }

  // Upload an attachment
  Future<void> uploadAttachment(UploadingMessage message) async {
    await firstMessage(chatRoom, _messageBox, chatConfig);
    try {
      print("Uploading attachment...");

      // Store the initial message in Hive with 'uploading' status
      final uploadingMessage =
          message.copyWith(status: MessageStatus.attachmentUploading);
      await _messageBox.put(message.id, uploadingMessage);

      final isOnline = await FirebaseUtils.isOnline();
      if (!isOnline) {
        print("No internet. Upload postponed.");
        final failedMessage = message.copyWith(status: MessageStatus.failed);
        await _messageBox.put(failedMessage.id, failedMessage);
        _failedAttachmentUploads.add(failedMessage); // Track failed upload
        return;
      }

      final downloadURL = await _uploadAttachment(message);
      if (downloadURL == null) {
        throw Exception("Failed to upload attachment");
      }

      // Update the message with the file URL and 'sent' status
      final sentMessage =
          message.copyWith(content: downloadURL, status: MessageStatus.sent);

      await _messageBox.put(sentMessage.id, sentMessage);
      await chatService.sendMassageToFireStore(
          partner: partner,
          chatRoomId: chatRoomId,
          updatedMessage: sentMessage);
      try {
        await chatService.updateChatRoomWithLastMessage(
            currentChatRoom: chatRoom, message: message);
      } catch (e) {
        print("😭😭😭😭😭😭😭Error updating chat room: $e");
      }

      // Remove from failed uploads if successful
      if (_failedAttachmentUploads.contains(message)) {
        _failedAttachmentUploads.remove(message);
      }
    } catch (e) {
      print("🚨 Error uploading attachment: $e");
      final failedMessage = message.copyWith(status: MessageStatus.failed);
      await _messageBox.put(failedMessage.id, failedMessage);
      _failedAttachmentUploads.add(failedMessage); // Track failed upload
    }
  }

  Future<String?> _uploadAttachment(UploadingMessage message) async {
    print("📤 Starting attachment upload...");

    final SupabaseClient supabase = Supabase.instance.client;
    final File file = File(message.content);

    // Check if file exists before uploading
    if (!file.existsSync()) {
      print("🚨 File not found: ${message.content}");
      final failedMessage = message.copyWith(status: MessageStatus.failed);
      await _messageBox.put(failedMessage.id, failedMessage);
      _failedAttachmentUploads.add(failedMessage);
      return null;
    }
    //todo! use supabase

    // final String fileName = "${message.id}/${file.path.split('/').last}";
    // const String bucketName = "khaled";

    // print("📂 Uploading file: $fileName to bucket: $bucketName");

    // try {
    //   // Upload file
    //   await supabase.storage.from(bucketName).upload(fileName, file);
    //   print("✅ Upload successful!");

    //   // Get public URL
    //   final String downloadURL =
    //       supabase.storage.from(bucketName).getPublicUrl(fileName);
    //   print("🔗 File accessible at: $downloadURL");

    //   return downloadURL;
    // } catch (e) {
    //   print("🚨 Upload failed: $e");

    //   final failedMessage = message.copyWith(status: MessageStatus.failed);
    //   await _messageBox.put(failedMessage.id, failedMessage);
    //   _failedAttachmentUploads.add(failedMessage);

    //   return null;
    // }
    //todo! use fire base
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child("chatAttachments/${message.id}/${file.path.split('/').last}");

    final UploadTask uploadTask = storageReference.putFile(file);

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      double progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      final updatedMessage =
          message.copyWith(progress: progress.toStringAsFixed(2).toString());
      _messageBox.put(updatedMessage.id, updatedMessage);
      print("Upload progress: ${progress.toStringAsFixed(2)}%");
    });

    await uploadTask;

    // Get the download URL
    final String downloadURL = await storageReference.getDownloadURL();
    print("Upload successful! Download URL: $downloadURL");
    return downloadURL;
  }

  @override
  Future<void> close() async {
    try {
      // Cancel Firestore subscription
      await _messagesSubscription?.cancel();

      // Remove Hive listener
      _messageBox.listenable().removeListener(_onBoxChange);

      // Cancel network connectivity listener
      await FirebaseUtils.onConnectivityChanged
          .drain(); // Ensures no pending events
    } catch (e) {
      print("🚨 Error during cleanup: $e");
    }

    return super.close();
  }
}

Future firstMessage(ChatRoom chatRoom, Box<MessageModel> _messageBox,
    ChatConfig chatConfig) async {
  // TODO check if chat room exists in firestore if not create it
  final messages = _messageBox.values.where((e) => e.chatRoomId == chatRoom.id);
  if (messages.isEmpty) {
    await ChatRoomRepository(chatConfig: chatConfig).setChatRooms(chatRoom);
  }
}
