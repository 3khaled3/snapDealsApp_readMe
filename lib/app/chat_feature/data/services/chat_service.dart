import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hive/hive.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_config.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_room.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_model.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_status.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_type.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/firebase_options.dart';

class ChatService {
  // ChatConfig object
  final ChatConfig chatConfig;

  ChatService({required this.chatConfig});

  Future<void> updateChatRoomWithLastMessage({
    required ChatRoom currentChatRoom,
    required MessageModel message,
  }) async {
    final Box<ChatRoom> chatRoomBox =
        Hive.box<ChatRoom>(chatConfig.chatRoomsCollection);

    ChatRoom? chatRoom = chatRoomBox.get(currentChatRoom.id);

    if (chatRoom == null) {
      chatRoomBox.put(currentChatRoom.id, currentChatRoom);

      chatRoom = chatRoomBox.get(currentChatRoom.id);
    }

    String? receiverID;

    for (var key in chatRoom!.members) {
      if (key != message.senderId) {
        receiverID = key;
        break;
      }
    }

    Map<String, int> unreadMessagesCount = chatRoom.unreadMessagesCount;

    unreadMessagesCount[receiverID!] =
        (unreadMessagesCount[receiverID] ?? 0) + 1;
    final updatedChatRoom = chatRoom.copyWith(
      lastMessageSender: message.senderId,
      lastMessageContent: message.type != MessageType.text
          ? message.type.name
          : message.content,
      lastMessageId: message.id,
      lastMessageTimestamp: message.timestamp,
      unreadMessagesCount: unreadMessagesCount,
    );
    await FirebaseFirestore.instance
        .collection(chatConfig.chatRoomsCollection)
        .doc(currentChatRoom.id)
        .set(updatedChatRoom.toJson());
    chatRoomBox.put(currentChatRoom.id, updatedChatRoom);
  }

  Future<void> updateChatRoomUnReadCounter({required String chatRoomId}) async {
    final Box<ChatRoom> chatRoomBox =
        Hive.box<ChatRoom>(chatConfig.chatRoomsCollection);
    final String userId = ProfileCubit.instance.state.profile.id;
    final ChatRoom? chatRoom = chatRoomBox.get(chatRoomId);

    if (chatRoom == null) return;

    final unreadMessagesCount = chatRoom.unreadMessagesCount;
    unreadMessagesCount[userId] = 0;

    final updatedChatRoom =
        chatRoom.copyWith(unreadMessagesCount: unreadMessagesCount);

    await FirebaseFirestore.instance
        .collection(chatConfig.chatRoomsCollection)
        .doc(chatRoomId)
        .set(updatedChatRoom.toJson());
  }

  Future<void> sendMassageToFireStore({
    required String chatRoomId,
    required MessageModel updatedMessage,
    required Partner partner,
  }) async {
    final String body = updatedMessage.type != MessageType.text
        ? updatedMessage.type.name
        : updatedMessage.content;
    final DatabaseReference dbRef = FirebaseDatabase.instance
        .ref()
        .child(chatConfig.chatMessagesCollection)
        .child(chatRoomId);

    await dbRef.child(updatedMessage.id).set(updatedMessage.toMap());

    // NotificationService.instance.sendPushNotification(
    //   type: ChatConfig.getChatType(chatConfig) == ChatType.support
    //       ? "supportChat"
    //       : "freeChat",
    //   partner: partner,
    //   title: "chat",
    //   body: body,
    // );
  }

  Future<void> updateMessagesToSeen({
    required String roomId,
    required List<MessageModel> localMessages,
  }) async {
    try {
      final String currentUser = ProfileCubit.instance.state.profile.id;
      final Map<String, dynamic> updates = {};

      for (var message in localMessages) {
        if (message.senderId != currentUser &&
            message.status != MessageStatus.read) {
          updates["${message.id}/status"] = MessageStatus.read.name;
        }
      }

      if (updates.isEmpty) return;

      await FirebaseDatabase.instance
          .ref("${chatConfig.chatMessagesCollection}/$roomId")
          .update(updates);
    } catch (e) {
      print("Error updating messages to 'seen': $e");
    }
  }
}

Future<void> updateMessagesToDelivered({
  required String senderId,
  required String receiverId,
  required ChatType chatType,
}) async {
  final ChatConfig chatConfig = ChatConfig.fromType(chatType);
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    }

    final String? chatRoomId =
        await _getChatRoomId(senderId, receiverId, chatConfig);
    if (chatRoomId == null) return;

    final DatabaseReference messagesRef = FirebaseDatabase.instance
        .ref(chatConfig.chatMessagesCollection)
        .child(chatRoomId);
    final DatabaseEvent messagesEvent =
        await messagesRef.orderByChild("senderId").equalTo(senderId).once();

    if (messagesEvent.snapshot.value == null) return;

    final Map<dynamic, dynamic> messages = messagesEvent.snapshot.value as Map;
    final Map<String, dynamic> updates = {};

    messages.forEach((key, value) {
      if (value["status"] == MessageStatus.sent.name) {
        updates["$key/status"] = MessageStatus.delivered.name;
      }
    });

    if (updates.isNotEmpty) {
      await messagesRef.update(updates);
    }
  } catch (e) {
    print("Error updating messages to 'delivered': $e");
  }
}

Future<String?> _getChatRoomId(
    String senderId, String receiverId, ChatConfig chatConfig) async {
  final chatRoomsQuery = await FirebaseFirestore.instance
      .collection(chatConfig.chatRoomsCollection)
      .where('members', arrayContainsAny: [senderId, receiverId])
      .limit(1)
      .get();

  if (chatRoomsQuery.docs.isEmpty) return null;

  return chatRoomsQuery.docs.first.id;
}
