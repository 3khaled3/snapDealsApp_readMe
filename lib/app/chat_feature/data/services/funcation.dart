import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_room.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_model.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_type.dart';
// import 'package:snap_deals/app/notification/data/notification_services.dart';
// import 'package:snap_deals/app/notification/data/send_push_notification.dart';


Future<void> updateChatRoomWithLastMessage(
    {required ChatRoom currentChatRoom, required MessageModel message}) async {
  final Box<ChatRoom> chatRoom0 = Hive.box<ChatRoom>('chatRooms');

  ChatRoom? chatRoom = chatRoom0.get(currentChatRoom.id);
  if (chatRoom == null) {
    chatRoom0.put(currentChatRoom.id, currentChatRoom);
    chatRoom = chatRoom0.get(currentChatRoom.id);
  }
  String? receiverID;
  for (var key in chatRoom!.members) {
    if (key != message.senderId) {
      receiverID = key;
      break;
    }
  }
  Map<String, int> unreadMessagesCount = chatRoom.unreadMessagesCount;
  int count = unreadMessagesCount[receiverID!] ?? 0;
  count++;
  unreadMessagesCount[receiverID] = count;

  final updatedChatRoom = chatRoom.copyWith(
    lastMessageSender: message.senderId,
    lastMessageContent:
        message.type != MessageType.text ? message.type.name : message.content,
    lastMessageId: message.id,
    lastMessageTimestamp: message.timestamp,
    unreadMessagesCount: unreadMessagesCount,
  );

  await FirebaseFirestore.instance
      .collection('chatRooms')
      .doc(currentChatRoom.id)
      .set(updatedChatRoom.toJson());
}

Future<void> updateChatRoomUnReadCounter({required String chatRoomId}) async {
  final Box<ChatRoom> chatRoom0 = Hive.box<ChatRoom>('chatRooms');

  final user = ProfileCubit.instance.state.profile.id;
  final chatRoom = chatRoom0.get(chatRoomId);
  Map<String, int> unreadMessagesCount = chatRoom!.unreadMessagesCount;

  unreadMessagesCount[user] = 0;

  final updatedChatRoom =
      chatRoom.copyWith(unreadMessagesCount: unreadMessagesCount);

  await FirebaseFirestore.instance
      .collection('chatRooms')
      .doc(chatRoomId)
      .set(updatedChatRoom.toJson());
}

Future<void> sendMassageToFireStore(
    {required String chatRoomId, required MessageModel updatedMessage}) async {
  // Send the message to Firestore
  await FirebaseFirestore.instance
      .collection('chatRooms')
      .doc(chatRoomId)
      .collection('messages')
      .doc(updatedMessage.id)
      .set(updatedMessage.toMap());
  // NotificationService.instance.sendPushNotification(
  //   deviceToken:
  //       "fcGKmRbDRZ2BRrIVdnzZa6:APA91bHwE-Xg_1Glvp5ELfMnx6-AW8wYqF6t4oKmAwglkpGmHO1CAzhfBIDeUDFf0pyHrzmDZA25ozU1dJPkA1tIRB_0Wf5MYteac1hvjEuLF1dIyLMhwPY",
  //   title: "chat",
  //   body: updatedMessage.content,
  // );
}
