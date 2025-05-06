import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_model.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_status.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/app/chat_feature/data/models/uploading_message.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/message_types/progress_indicator.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:shimmer/shimmer.dart';

class ImageMessageBubble extends StatelessWidget {
  final MessageModel message;

  const ImageMessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    print("${message.status}");
    final String heroTag =
        '${message.id}_${message.senderId}_${DateTime.now().millisecondsSinceEpoch}';

    Widget? stateIcon;
    final bool isSender =
        message.senderId == ProfileCubit.instance.state.profile.id;
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
    final String sendTime = DateFormat('h:mm a').format(
      DateTime.fromMillisecondsSinceEpoch(message.timestamp),
    );
    Widget image = message.status == MessageStatus.attachmentUploading ||
            message.status == MessageStatus.failed
        ? Image.file(
            File(message.content),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.width * .5,
          )
        : CachedNetworkImage(
            imageUrl: message.content,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.width * .5,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(color: Colors.white),
            ),
            errorWidget: (context, url, error) => SvgPicture.asset(
              AppImageAssets.defaultProfile,
              fit: BoxFit.cover,
            ),
          );
// var uuid = Uuid().v4();
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .5,
          maxHeight: MediaQuery.of(context).size.width * .5,
          minHeight: MediaQuery.of(context).size.width * .5,
          minWidth: MediaQuery.of(context).size.width * .1,
        ),
        decoration: BoxDecoration(
          color: isSender ? ColorsBox.mainColor : ColorsBox.greyReceivedMessage,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: GestureDetector(
          // onLongPress: onLongPress,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return _DisPlayImage(
                _DisPlayImageArgs(tag: heroTag, image: image),
              );
            }));
          },
          child: Hero(
            tag: heroTag,
            child: Stack(
              children: [
                // Image container with border and background
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: image,
                ),
                Positioned(
                  bottom: 4,
                  right: 6,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: isSender
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      if (stateIcon != null) stateIcon,
                      4.pw,
                      Text(
                        sendTime,
                        style: AppTextStyles.bold12().copyWith(
                          color: ColorsBox.white,
                          shadows: [
                            const Shadow(
                              blurRadius: 2,
                              color: ColorsBox.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Detail screen for the image, displayed when tapped
class _DisPlayImageArgs {
  final String tag;
  final Widget image;

  _DisPlayImageArgs({required this.tag, required this.image});
}

class _DisPlayImage extends StatelessWidget {
  final _DisPlayImageArgs args;
  const _DisPlayImage(this.args);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Center(
          child: Hero(
            tag: args.tag,
            child: args.image,
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
