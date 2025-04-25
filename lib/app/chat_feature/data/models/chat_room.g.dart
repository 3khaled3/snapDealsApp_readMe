// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatRoomAdapter extends TypeAdapter<ChatRoom> {
  @override
  final int typeId = 0;

  @override
  ChatRoom read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatRoom(
      id: fields[0] as String,
      members: (fields[1] as List).cast<String>(),
      unreadMessagesCount: (fields[2] as Map).cast<String, int>(),
      lastMessageId: fields[3] as String,
      lastMessageContent: fields[4] as String,
      lastMessageSender: fields[5] as String,
      lastMessageTimestamp: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChatRoom obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.members)
      ..writeByte(2)
      ..write(obj.unreadMessagesCount)
      ..writeByte(3)
      ..write(obj.lastMessageId)
      ..writeByte(4)
      ..write(obj.lastMessageContent)
      ..writeByte(5)
      ..write(obj.lastMessageSender)
      ..writeByte(6)
      ..write(obj.lastMessageTimestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatRoomAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
