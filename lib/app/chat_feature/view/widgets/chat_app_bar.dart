import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_button_row.dart';
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                        child: Row(
                      children: [
                        CustomBackButton(),
                      ],
                    )),
                    Text(
                      title,
                      style: AppTextStyles.bold22()
                          .copyWith(color: ColorsBox.mainColor),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
            Divider(height: 1, color: ColorsBox.greyWithOpacity20),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
