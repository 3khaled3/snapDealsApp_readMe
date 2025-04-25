import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_room.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_model.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_status.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_type.dart';
import 'package:snap_deals/app/chat_feature/data/models/uploading_message.dart';
import 'package:snap_deals/app/chat_feature/data/repositories/chat_room_repository.dart';
import 'package:snap_deals/app/chat_feature/data/services/funcation.dart';
import 'package:snap_deals/core/utils/network_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatMessagesCubit extends Cubit<List<MessageModel>> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Box<MessageModel> _messageBox;
  final List<MessageModel> fieldMessages = [];
  final List<UploadingMessage> _failedAttachmentUploads = [];
  ChatRoom chatRoom;
  StreamSubscription<QuerySnapshot>? _messagesSubscription;
  late final VoidCallback _onBoxChange;
  late String chatRoomId;

  ChatMessagesCubit({required this.chatRoom}) : super([]) {
    chatRoomId = chatRoom.id;
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

            final future = sendMassageToFireStore(
                chatRoomId: chatRoomId, updatedMessage: updatedMessage);
            final future2 = _messageBox.put(message.id, updatedMessage);

            futures.add(future);
            futures.add(future2);
          }
          await Future.wait(futures);
          try {
            await updateChatRoomWithLastMessage(
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
    _messageBox = await Hive.openBox<MessageModel>('messages');
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
    updateChatRoomUnReadCounter(chatRoomId: chatRoomId);

    _messagesSubscription = _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .listen((snapshot) async {
      for (final doc in snapshot.docs) {
        final message = MessageModel.fromMap(doc.data());

        await _messageBox.put(message.id, message);
      }
    }, onError: (error) {
      print("😭😭😭😭😭😭😭Error fetching messages: $error");
    });
  }

  // Send a new message
  Future<void> sendMessage(MessageModel message) async {
    await firstMessage(chatRoom, _messageBox);

    try {
      // Cache the message in Hive
      await _messageBox.put(message.id, message);
      final isOnline = await FirebaseUtils.isOnline();
      if (isOnline) {
        final updatedMessage = message.copyWith(status: MessageStatus.sent);

        // Send the message to Firestore
        await sendMassageToFireStore(
            chatRoomId: chatRoomId, updatedMessage: updatedMessage);
        // Update the chat room with the last message
        try {
          await updateChatRoomWithLastMessage(
              currentChatRoom: chatRoom, message: message);
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
    await firstMessage(chatRoom, _messageBox);
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
      await sendMassageToFireStore(
          chatRoomId: chatRoomId, updatedMessage: sentMessage);
      try {
        await updateChatRoomWithLastMessage(
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

    final String fileName = "${message.id}/${file.path.split('/').last}";
    const String bucketName = "khaled";

    print("📂 Uploading file: $fileName to bucket: $bucketName");

    try {
      // Upload file
      await supabase.storage.from(bucketName).upload(fileName, file);
      print("✅ Upload successful!");

      // Get public URL
      final String downloadURL =
          supabase.storage.from(bucketName).getPublicUrl(fileName);
      print("🔗 File accessible at: $downloadURL");

      return downloadURL;
    } catch (e) {
      print("🚨 Upload failed: $e");

      final failedMessage = message.copyWith(status: MessageStatus.failed);
      await _messageBox.put(failedMessage.id, failedMessage);
      _failedAttachmentUploads.add(failedMessage);

      return null;
    }
  }

  @override
  Future<void> close() async {
    _messagesSubscription?.cancel();
    _messageBox.listenable().removeListener(_onBoxChange);
    return super.close();
  }
}

Future firstMessage(ChatRoom chatRoom, Box<MessageModel> _messageBox) async {
  print("right 11");
  final messages = _messageBox.values.where((e) => e.chatRoomId == chatRoom.id);
  if (messages.isEmpty) {
    print("right 222");
    await ChatRoomRepository().setChatRooms(chatRoom);
    print("right 333");
  }
  print("right 444");
}
