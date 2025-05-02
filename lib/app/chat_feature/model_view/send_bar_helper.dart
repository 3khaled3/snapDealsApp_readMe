import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_model.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_status.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_type.dart';
import 'package:snap_deals/app/chat_feature/data/models/uploading_message.dart';
import 'package:snap_deals/app/chat_feature/data/services/determine_position.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/send_attachment_menu.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';

import 'chat_messages_cubit.dart';

class SendBarHelper {
  final BuildContext context;
  final String chatRoomId;

  SendBarHelper(this.context, this.chatRoomId);

  void openAttachmentMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (newContext) {
        return AttachmentMenu(
          onTapImage: () =>
              _handleFileUpload(FileType.image, MessageType.image),
          onTapVideo: () =>
              _handleFileUpload(FileType.video, MessageType.video),
          onTapFile: () => _handleFileUpload(FileType.any, MessageType.file),
          onTapLocation: () => _sendLocation(),
        );
      },
    );
  }

  void _handleFileUpload(FileType fileType, MessageType messageType) async {
    final result = await FilePicker.platform.pickFiles(type: fileType);
    if (result != null && result.files.isNotEmpty) {
      _uploadAttachment(result.files.single.path!, messageType);
    } else {
      _showErrorSnackBar('No file selected.');
    }
  }

  void _uploadAttachment(String filePath, MessageType type) {
    final message = UploadingMessage(
      chatRoomId: chatRoomId,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: ProfileCubit.instance.state.profile.id,
      content: filePath,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      type: type,
      status: MessageStatus.attachmentUploading,
      progress: "0",
    );

    try {
      context.read<ChatMessagesCubit>().uploadAttachment(message);
    } catch (e) {
      _showErrorSnackBar('Failed to upload file: ${e.toString()}');
    }
  }

  void sendMessage(String text) {
    final message = MessageModel(
      chatRoomId: chatRoomId,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: ProfileCubit.instance.state.profile.id,
      content: text,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      type: MessageType.text,
      status: MessageStatus.sending,
    );

    try {
      context.read<ChatMessagesCubit>().sendMessage(message);
    } catch (e) {
      _showErrorSnackBar('Failed to send message. Please try again.');
    }
  }

  void uploadAudio(String filePath) {
    _uploadAttachment(filePath, MessageType.audio);
  }

  void _sendLocation() {
    determinePosition(context).then((position) {
      if (position != null) {
        final message = MessageModel(
          chatRoomId: chatRoomId,
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderId: ProfileCubit.instance.state.profile.id,
          content:
              'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}',
          timestamp: DateTime.now().millisecondsSinceEpoch,
          type: MessageType.location,
          status: MessageStatus.sending,
        );
        context.read<ChatMessagesCubit>().sendMessage(message);
      }
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
