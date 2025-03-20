import 'package:flutter/material.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomListTile extends StatelessWidget {
  final IconData? leadingIcon;
  final String title;
  final VoidCallback onTap;

  const CustomListTile({
    super.key,
    this.leadingIcon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIcon == null
          ? null
          : Icon(
              leadingIcon,
              color: ColorsBox.brightBlue,
              size: 30,
            ),
      title: Text(
        title,
        style: AppTextStyles.regular18(),
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right,
        color: ColorsBox.brightBlue,
        size: 25,
      ),
      onTap: onTap,
    );
  }
}
