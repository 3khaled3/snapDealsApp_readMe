import 'package:hive/hive.dart';

part 'message_type.g.dart'; // Add this line

@HiveType(typeId: 2) // Unique typeId for MessageType
enum MessageType {
  @HiveField(0)
  text,
  @HiveField(1)
  image,
  @HiveField(2)
  video,
  @HiveField(3)
  location,
  @HiveField(4)
  audio,
  @HiveField(5)
  file,
}
