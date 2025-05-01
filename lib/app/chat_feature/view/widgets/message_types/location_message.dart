import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_model.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

import 'package:snap_deals/app/chat_feature/data/models/message_status.dart';
import 'package:snap_deals/app/chat_feature/data/models/uploading_message.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/message_types/progress_indicator.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationMessageBubble extends StatelessWidget {
  final MessageModel message;
  const LocationMessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    // print("message.senderId: ${message.content}");
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
            color: ColorsBox.mainColor,
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
    Future<void> _openLocation() async {
      final Uri uri = Uri.parse(message.content);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch ${message.content});';
      }
    }

    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * .7,
            minWidth: MediaQuery.of(context).size.width * .3,
            maxHeight: MediaQuery.of(context).size.width * .3,
          ),
          decoration: BoxDecoration(
            color:
                isSender ? ColorsBox.mainColor : ColorsBox.greyReceivedMessage,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: GestureDetector(
            onTap: _openLocation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                4.ph,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Icon(
                        Icons.location_on,
                        color: isSender ? Colors.white : ColorsBox.mainColor,
                        size: 50,
                      ),
                    ),
                  ],
                ),
                8.ph,
                Text(
                  'View Location',
                  style: AppTextStyles.bold18().copyWith(
                    color: isSender
                        ? ColorsBox.white.withOpacity(0.8)
                        : ColorsBox.mainColor.withOpacity(0.6),
                  ),
                ),
                // 4.ph,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: isSender
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    if (stateIcon != null) stateIcon,
                    4.pw,
                    Text(
                      sendTime,
                      style: AppTextStyles.regular12().copyWith(
                        color: isSender
                            ? ColorsBox.white.withOpacity(0.8)
                            : ColorsBox.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
