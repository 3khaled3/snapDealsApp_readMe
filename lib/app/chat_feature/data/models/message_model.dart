import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'message_status.dart';
import 'message_type.dart';
part 'message_model.g.dart';

@HiveType(typeId: 1)
class MessageModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String senderId;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final int timestamp;
  @HiveField(4)
  final MessageType type;
  @HiveField(5)
  final MessageStatus status;
  @HiveField(6)
  final String? replyToMessageId;
  @HiveField(7)
  final String chatRoomId;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.type,
    required this.status,
    required this.chatRoomId,
    this.replyToMessageId,
  });

  factory MessageModel.fromMap(Map<String, dynamic> data) {
    print("data['chatRoomId'] ${data['chatRoomId']}");
    return MessageModel(
      id: data['id'],
      senderId: data['senderId'] ?? '',
      content: data['content'] ?? '',
      timestamp: data['timestamp'] ?? 0,
      type: MessageType.values.firstWhere(
          (e) => e.toString().split('.').last == (data['type'] ?? 'text'),
          orElse: () => MessageType.text),
      status: MessageStatus.values.firstWhere(
          (e) => e.toString().split('.').last == (data['status'] ?? 'sent'),
          orElse: () => MessageStatus.sent),
      replyToMessageId: data['replyToMessageId'],
      chatRoomId: data['chatRoomId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "senderId": senderId,
      "content": content,
      "timestamp": timestamp,
      "type": type.toString().split('.').last,
      "status": status.toString().split('.').last,
      "replyToMessageId": replyToMessageId,
      "chatRoomId": chatRoomId,
    };
  }

  // Add copyWith method
  MessageModel copyWith({
    String? id,
    String? senderId,
    String? content,
    int? timestamp,
    MessageType? type,
    MessageStatus? status,
    String? replyToMessageId,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      status: status ?? this.status,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
      chatRoomId: chatRoomId,
    );
  }

  List<Object?> get props => [
        id,
        senderId,
        content,
        timestamp,
        type,
        status,
        replyToMessageId,
        chatRoomId
      ];
}

dynamic deepConvert(dynamic value) {
  if (value is Map) {
    return value.map((key, val) {
      if (key is! String) {
        throw ArgumentError(
            'Map key must be a string, but found ${key.runtimeType}');
      }
      return MapEntry(key, deepConvert(val));
    });
  } else if (value is List) {
    bool hasDoubleValues =
        value.any((item) => item is double); // Check if any item is a double
    final values = hasDoubleValues ? <double>[] : <int>[];
    List dynamicValues = value.map((item) {
      if (item is num) {
        if (!hasDoubleValues) {
          values.add(item.toInt());
          return item.toInt(); // Convert numbers to double
        } else {
          values.add(item.toDouble());
          return item.toDouble(); // Convert numbers to double
        }
      }
      return deepConvert(item); // Recursively handle nested structures
    }).toList();
    if (values.isNotEmpty) {
      return values;
    } else {
      return dynamicValues;
    }
  } else if (value is num) {
    if (value is int) {
      print("1111111num2 : $value");
      return value.toInt(); // Convert numeric values to double
    }

    return value.toDouble();
  } else {
    return value; // Return the value unchanged if it's not a list, map, or numeric
  }
}
