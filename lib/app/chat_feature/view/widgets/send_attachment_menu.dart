import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';

import 'chat_icon_button.dart';

class AttachmentMenu extends StatelessWidget {
  const AttachmentMenu({
    super.key,
    required this.onTapImage,
    required this.onTapVideo,
    required this.onTapFile,
    required this.onTapLocation,
  });
  final void Function() onTapImage;
  final void Function() onTapVideo;
  final void Function() onTapFile;
  final void Function() onTapLocation;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AttachmentOption(
                    icon: Icons.image,
                    label: context.tr.Image,
                    color: Colors.blue,
                    onTap: onTapImage),
                AttachmentOption(
                    icon: Icons.video_library,
                    label: context.tr.Video,
                    color: Colors.green,
                    onTap: onTapVideo),
                AttachmentOption(
                    icon: Icons.insert_drive_file,
                    label: context.tr.Files,
                    color: Colors.orange,
                    onTap: onTapFile),
                AttachmentOption(
                  icon: Icons.location_on,
                  label: context.tr.Location,
                  color: Colors.red,
                  onTap: onTapLocation,
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
