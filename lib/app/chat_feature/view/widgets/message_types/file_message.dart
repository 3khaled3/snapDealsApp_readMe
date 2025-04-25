import 'dart:io';
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
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FileMessageBubble extends StatelessWidget {
  final MessageModel message;

  const FileMessageBubble({super.key, required this.message});

  Future<void> downloadFile(String url, String filename) async {
    try {
      print("🎃 pdf link is $url");

      final response = await http.get(Uri.parse(url));
      print("❌ Downloading...");

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        // Get temp directory path
        final tempDir = await getDownloadsDirectory();
        final filePath = '${tempDir!.path}/chatAttachments/$filename';

        // Extract the directory path (excluding the filename)
        final fileDirectory = File(filePath).parent;

        // Ensure directory exists
        if (!await fileDirectory.exists()) {
          await fileDirectory.create(recursive: true);
        }

        // Write file
        final file = File(filePath);
        await file.writeAsBytes(bytes);

        print("✅ File downloaded to ${file.path}");
      } else {
        print("❌ Failed to download file. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print('❌ An error occurred while downloading the file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isSender =
        message.senderId == ProfileCubit.instance.state.profile.id;

    Widget? stateIcon;
    if (isSender) {
      switch (message.status) {
        case MessageStatus.sending:
          stateIcon =
              const Icon(Icons.hourglass_empty, size: 18, color: Colors.white);
          break;
        case MessageStatus.sent:
          stateIcon = const Icon(Icons.done, size: 18, color: Colors.white);
          break;
        case MessageStatus.delivered:
          stateIcon = const Icon(Icons.done_all, size: 18, color: Colors.white);
          break;
        case MessageStatus.read:
          stateIcon =
              const Icon(Icons.done_all, size: 18, color: ColorsBox.mainColor);
          break;
        case MessageStatus.failed:
          stateIcon = const Icon(Icons.error, size: 18, color: ColorsBox.red);
          break;
        case MessageStatus.attachmentUploading:
          stateIcon = CustomProgressIndicator(
              value: (message as UploadingMessage).progress);
          break;
      }
    }

    final String sendTime = DateFormat('h:mm a').format(
      DateTime.fromMillisecondsSinceEpoch(message.timestamp),
    );

    final String fileName = Uri.decodeComponent(
      Uri.parse(message.content).pathSegments.last,
    );

    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
            minWidth: MediaQuery.of(context).size.width * 0.3,
          ),
          decoration: BoxDecoration(
            color:
                isSender ? ColorsBox.mainColor : ColorsBox.greyReceivedMessage,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              4.ph,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.insert_drive_file,
                      color: isSender ? Colors.white : ColorsBox.mainColor,
                      size: 24),
                  8.pw,
                  Text(
                    fileName,
                    style: AppTextStyles.regular16().copyWith(
                        color: isSender ? Colors.white : ColorsBox.mainColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // if (!isSender)
                  IconButton(
                    icon: Icon(Icons.download,
                        color: isSender ? Colors.white : ColorsBox.mainColor),
                    onPressed: () => downloadFile(message.content, fileName),
                  ),
                ],
              ),
              4.ph,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  if (stateIcon != null) stateIcon,
                  4.pw,
                  Text(
                    sendTime,
                    style: AppTextStyles.regular12().copyWith(
                      color: isSender ? Colors.white : ColorsBox.black,
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
