import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
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
    this.isAddView = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: ColorsBox.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            if (leadingIcon != null)
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorsBox.brightBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  leadingIcon,
                  color: ColorsBox.brightBlue,
                  size: 22,
                ),
              ),
            16.pw,
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.regular18().copyWith(
                  fontFamily: AppTextStyles.fontFamilyLora,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: ColorsBox.brightBlue,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
