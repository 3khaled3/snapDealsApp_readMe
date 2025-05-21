import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomHeaderAddView extends StatelessWidget {
  const CustomHeaderAddView(
      {super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: Icon(
              icon,
              color: ColorsBox.brightBlue,
              size: 40,
            )),
        23.pw,
        Text(
          title,
          style: AppTextStyles.bold18()
              .copyWith(fontFamily: context.tr.fontFamilyLora),
        )
      ],
    );
  }
}
