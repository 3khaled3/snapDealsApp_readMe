import 'package:flutter/material.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomListTile extends StatelessWidget {
  final IconData? leadingIcon;
  final String title;
  final VoidCallback onTap;
  final bool? isAddView;

  const CustomListTile({
    super.key,
    this.leadingIcon,
    required this.title,
    required this.onTap,
    this.isAddView,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIcon == null
          ? null
          : isAddView!
              ? Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(color: ColorsBox.brightBlue),
                  child: Icon(
                    leadingIcon,
                    color: ColorsBox.white,
                    size: 30,
                  ),
                )
              : Icon(
                  leadingIcon,
                  color: ColorsBox.brightBlue,
                  size: 30,
                ),
      title: Text(
        title,
        style: AppTextStyles.regular18()
            .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
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
