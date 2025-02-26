import 'package:flutter/material.dart';
import 'package:snap_deals/core/themes/app_colors.dart';

import '../../../../core/themes/text_styles.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 19),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: ColorsBox.brightBlue,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Center(
          child: Text(title,
              style: AppTextStyles.medium22().copyWith(
                  fontFamily: AppTextStyles.fontFamilyLora,
                  color: ColorsBox.white)),
        ),
      ),
    );
  }
}
