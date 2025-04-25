import 'package:hive/hive.dart';

part 'message_status.g.dart'; // Add this line

@HiveType(typeId: 3) // Unique typeId for MessageStatus
enum MessageStatus {
  @HiveField(0)
  sent,
  @HiveField(1)
  delivered,
  @HiveField(2)
  read,
  @HiveField(3)
  failed,
  @HiveField(4)
  sending,
  @HiveField(5)
  attachmentUploading,
}
