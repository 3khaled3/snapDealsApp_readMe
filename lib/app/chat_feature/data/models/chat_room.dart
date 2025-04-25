import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'chat_room.g.dart'; // Generated file

@HiveType(typeId: 0)
class ChatRoom {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final List<String> members;
  @HiveField(2)
  final Map<String, int> unreadMessagesCount;
  @HiveField(3)
  final String lastMessageId;
  @HiveField(4)
  final String lastMessageContent;
  @HiveField(5)
  final String lastMessageSender;
  @HiveField(6)
  final int lastMessageTimestamp; 

  ChatRoom({
    required this.id,
    required this.members,
    required this.unreadMessagesCount,
    required this.lastMessageId,
    required this.lastMessageContent,
    required this.lastMessageSender,
    required this.lastMessageTimestamp,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> data) {
    return ChatRoom(
      id: data['id'],
      members: List<String>.from(data['members'] ?? []),
      unreadMessagesCount:
          Map<String, int>.from(data['unreadMessagesCount'] ?? {}),
      lastMessageId: data['lastMessageId'] ?? '',
      lastMessageContent: data['lastMessageContent'] ?? '',
      lastMessageSender: data['lastMessageSender'] ?? '',
      lastMessageTimestamp: (data['lastMessageTimestamp'] as Timestamp?)
              ?.millisecondsSinceEpoch ??
          0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "members": members,
      "unreadMessagesCount": unreadMessagesCount,
      "lastMessageId": lastMessageId,
      "lastMessageContent": lastMessageContent,
      "lastMessageSender": lastMessageSender,
      "lastMessageTimestamp":
          Timestamp.fromMillisecondsSinceEpoch(lastMessageTimestamp),
    };
  }

  // Add the copyWith method
  ChatRoom copyWith({
    String? id,
    List<String>? members,
    Map<String, int>? unreadMessagesCount,
    String? lastMessageId,
    String? lastMessageContent,
    String? lastMessageSender,
    int? lastMessageTimestamp, // Change type to int
  }) {
    return ChatRoom(
      id: id ?? this.id,
      members: members ?? this.members,
      unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      lastMessageContent: lastMessageContent ?? this.lastMessageContent,
      lastMessageSender: lastMessageSender ?? this.lastMessageSender,
      lastMessageTimestamp: lastMessageTimestamp ?? this.lastMessageTimestamp,
    );
  }
}
