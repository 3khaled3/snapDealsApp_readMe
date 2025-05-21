import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomAddDetailsTitle extends StatelessWidget {
  const CustomAddDetailsTitle({super.key, required this.title, this.icon});
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr.category,
          style: AppTextStyles.semiBold12()
              .copyWith(fontFamily: context.tr.fontFamilyLora),
        ),
        7.ph,
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(color: ColorsBox.brightBlue),
              child: Icon(
                icon,
                color: ColorsBox.white,
                size: 30,
              ),
            ),
            10.pw,
            Text(
              title,
              style: AppTextStyles.semiBold12()
                  .copyWith(fontFamily: context.tr.fontFamilyLora),
            ),
          ],
        ),
      ],
    );
  }
}
