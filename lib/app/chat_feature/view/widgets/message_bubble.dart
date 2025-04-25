import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_model.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_type.dart';
import 'package:snap_deals/app/chat_feature/model_view/chat_messages_cubit.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/message_types/audio_message.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/message_types/file_message.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/message_types/image_message.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/message_types/location_message.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/message_types/text_message.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/message_types/video_message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    print("1111111ww");
    switch (message.type) {
      case MessageType.text:
        return TextMessageBubble(message: message);
      case MessageType.image:
        return ImageMessageBubble(message: message);
      case MessageType.audio:
        return AudioMessageBubble(message: message);
      case MessageType.video:
        return VideoMessageBubble(message: message);
      case MessageType.file:
        return FileMessageBubble(message: message);
      case MessageType.location:
        return LocationMessageBubble(message: message);
    }
  }
}

class FinalMessageBubble extends StatelessWidget {
  const FinalMessageBubble({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatMessagesCubit, List<MessageModel>>(
      buildWhen: (previousMessages, currentMessages) {
        final previousMessage = previousMessages.firstWhere(
          (m) => m.id == message.id,
          orElse: () => message,
        );
        final currentMessage = currentMessages.firstWhere(
          (m) => m.id == message.id,
          orElse: () => message,
        );
        return previousMessage != currentMessage;
      },
      builder: (context, newMessages) {
        debugPrint("updateState: ${message.id}");
        return MessageBubble(
          key: GlobalKey(debugLabel: message.id),
          message: newMessages.firstWhere(
            (m) => m.id == message.id,
            orElse: () => message,
          ),
        );
      },
    );
  }
}
