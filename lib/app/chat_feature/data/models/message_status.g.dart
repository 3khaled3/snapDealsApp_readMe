// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageStatusAdapter extends TypeAdapter<MessageStatus> {
  @override
  final int typeId = 3;

  @override
  MessageStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MessageStatus.sent;
      case 1:
        return MessageStatus.delivered;
      case 2:
        return MessageStatus.read;
      case 3:
        return MessageStatus.failed;
      case 4:
        return MessageStatus.sending;
      case 5:
        return MessageStatus.attachmentUploading;
      default:
        return MessageStatus.sent;
    }
  }

  @override
  void write(BinaryWriter writer, MessageStatus obj) {
    switch (obj) {
      case MessageStatus.sent:
        writer.writeByte(0);
        break;
      case MessageStatus.delivered:
        writer.writeByte(1);
        break;
      case MessageStatus.read:
        writer.writeByte(2);
        break;
      case MessageStatus.failed:
        writer.writeByte(3);
        break;
      case MessageStatus.sending:
        writer.writeByte(4);
        break;
      case MessageStatus.attachmentUploading:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
