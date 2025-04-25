import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:intl/intl.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_model.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_status.dart';
import 'package:snap_deals/app/chat_feature/data/models/uploading_message.dart';
import 'package:snap_deals/app/chat_feature/view/widgets/message_types/progress_indicator.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:path_provider/path_provider.dart';

import '../online_video_player.dart';

class VideoMessageBubble extends StatelessWidget {
  final MessageModel message;

  const VideoMessageBubble({
    super.key,
    required this.message,
  });

  Future<File?> _generateThumbnail(String videoUrl) async {
    try {
      final cacheDir = await getTemporaryDirectory();
      final thumbnailPath = '${cacheDir.path}/${Uri.decodeComponent(
        Uri.parse(message.content).pathSegments.last,
      )}.jpg';

      if (await File(thumbnailPath).exists()) {
        // Use cached thumbnail
        return File(thumbnailPath);
      }

      // Generate new thumbnail
      final thumbnail = await VideoThumbnail.thumbnailFile(
        video: videoUrl,
        thumbnailPath: thumbnailPath,
        imageFormat: ImageFormat.JPEG,
        quality: 25,
      );

      return thumbnail != null ? File(thumbnail.path) : null;
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
    final String sendTime = DateFormat('h:mm a').format(
      DateTime.fromMillisecondsSinceEpoch(message.timestamp),
    );
    Widget video = message.status == MessageStatus.attachmentUploading ||
            message.status == MessageStatus.failed
        ? OnlineVideoPlayer(videoUrl: message.content)
        : FutureBuilder<File?>(
            future: _generateThumbnail(message.content),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.hasError || !snapshot.hasData) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.video_file),
                );
              }

              return Stack(
                children: [
                  Image.file(
                    snapshot.data!,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width * .5,
                    width: MediaQuery.of(context).size.width * .5,
                  ),
                  Center(
                    child: Icon(
                      Icons.play_circle_fill_rounded,
                      color: ColorsBox.white.withOpacity(.5),
                      size: 50,
                    ),
                  ),
                ],
              );
            },
          );

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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return _DisPlayVideo(
                    _DisPlayVideoArgs(
                      tag: heroTag,
                      video: OnlineVideoPlayer(
                        videoUrl: message.content,
                      ),
                    ),
                  );
                },
              ),
            );
          },
          child: Hero(
            tag: heroTag,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: video,
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

/// Detail screen for the Video, displayed when tapped
class _DisPlayVideoArgs {
  final String tag;
  final Widget video;

  _DisPlayVideoArgs({required this.tag, required this.video});
}

class _DisPlayVideo extends StatelessWidget {
  final _DisPlayVideoArgs args;
  const _DisPlayVideo(this.args);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video player"),
      ),
      body: Center(
        child: Hero(
          tag: args.tag,
          child: args.video,
        ),
      ),
    );
  }
}
