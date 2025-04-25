import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_model.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_status.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_type.dart';

class UploadingMessage extends MessageModel {
  final String progress;

  UploadingMessage({
    required this.progress,
    required super.id,
    required super.senderId,
    required super.content,
    required super.timestamp,
    required super.type,
    required super.status,
    required super.chatRoomId,
    super.replyToMessageId,
  });

  // Optionally, you can override the toMap method to include the progress field
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map['progress'] = progress;
    return map;
  }

  // Optionally, you can add a fromMap factory constructor
  factory UploadingMessage.fromMap(Map<String, dynamic> data) {
    return UploadingMessage(
      id: data['id'],
      chatRoomId: data['chatRoomId'],
      senderId: data['senderId'] ?? '',
      content: data['content'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.millisecondsSinceEpoch ?? 0,
      type: MessageType.values.firstWhere(
          (e) => e.toString().split('.').last == (data['type'] ?? 'text'),
          orElse: () => MessageType.text),
      status: MessageStatus.values.firstWhere(
          (e) => e.toString().split('.').last == (data['status'] ?? 'sent'),
          orElse: () => MessageStatus.sent),
      replyToMessageId: data['replyToMessageId'],
      progress: data['progress'] ?? '0%',
    );
  }

  // Optionally, you can add a copyWith method
  @override
  UploadingMessage copyWith({
    String? id,
    String? senderId,
    String? content,
    int? timestamp,
    MessageType? type,
    MessageStatus? status,
    String? replyToMessageId,
    String? progress,
    String? chatRoomId,
  }) {
    return UploadingMessage(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      status: status ?? this.status,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
      progress: progress ?? this.progress,
      chatRoomId: chatRoomId ?? this.chatRoomId,
    );
  }

  @override
  List<Object?> get props => super.props..add(progress);
}
