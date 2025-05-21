import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_button_row.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF9FAFB),
      child: SafeArea(
        child: Column(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bold22()
                        .copyWith(color: ColorsBox.mainColor),
                  ),
                ],
              ),
            ),
            12.ph,
            const Divider(height: 1, color: ColorsBox.greyWithOpacity20),
            12.ph,
          ],
        ),
      ),
    );
  }
}
