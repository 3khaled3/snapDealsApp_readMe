import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
// import 'package:flutter_sound/flutter_sound.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_status.dart';
import 'package:snap_deals/app/chat_feature/data/models/uploading_message.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/message_types/progress_indicator.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:intl/intl.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_model.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'dart:async';

part 'audio_player.dart';

class AudioMessageBubble extends StatelessWidget {
  final MessageModel message;
  const AudioMessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    Widget? stateIcon;
    final bool isSender =
        message.senderId == ProfileCubit.instance.state.profile.id;

    // Determine the status icon based on the message state
    if (isSender) {
      switch (message.status) {
        case MessageStatus.sending:
          stateIcon = const Icon(
            Icons.hourglass_empty_sharp,
            size: 18,
            color: ColorsBox.white,
          );
          break;
        case MessageStatus.sent:
          stateIcon = const Icon(
            Icons.done,
            size: 18,
            color: ColorsBox.white,
          );
          break;
        case MessageStatus.delivered:
          stateIcon = const Icon(
            Icons.done_all,
            size: 18,
            color: ColorsBox.white,
          );
          break;
        case MessageStatus.read:
          stateIcon = const Icon(
            Icons.done_all,
            size: 18,
            color: Color(0xff69BFFF),
          );
          break;
        case MessageStatus.failed:
          stateIcon = const Icon(
            Icons.error,
            size: 18,
            color: ColorsBox.red,
          );
        case MessageStatus.attachmentUploading:
          stateIcon = CustomProgressIndicator(
              value: (message as UploadingMessage).progress);
      }
    }
    // Format the send time
    final String sendTime = DateFormat('h:mm a').format(
      DateTime.fromMillisecondsSinceEpoch(message.timestamp),
    );

    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Container(
          width: MediaQuery.of(context).size.width * .7,
          decoration: BoxDecoration(
            color:
                isSender ? ColorsBox.mainColor : ColorsBox.greyReceivedMessage,
            borderRadius: BorderRadius.circular(12),
          ),
          // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PlayerWidget(
                url: message.content,
                color: !isSender
                    ? ColorsBox.mainColor
                    : ColorsBox.greyReceivedMessage,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    isSender ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  if (stateIcon != null) stateIcon,
                  4.pw,
                  Text(
                    sendTime,
                    style: AppTextStyles.regular12().copyWith(
                      color: !isSender
                          ? ColorsBox.mainColor
                          : ColorsBox.greyReceivedMessage,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
