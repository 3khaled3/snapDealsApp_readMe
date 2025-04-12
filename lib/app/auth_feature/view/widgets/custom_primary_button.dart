import 'package:flutter/material.dart';
import 'package:snap_deals/core/themes/app_colors.dart';

import '../../../../core/themes/text_styles.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isWhite,
  });
  final String title;
  final Function() onTap;
  final bool? isWhite;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Expanded(
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: isWhite == true ? ColorsBox.white : ColorsBox.brightBlue,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: isWhite == true
                  ? Border.all(color: ColorsBox.slateGrey)
                  : Border.all(color: ColorsBox.brightBlue),
            ),
            child: Center(
              child: Text(title,
                  style: AppTextStyles.semiBold18().copyWith(
                    // fontFamily: AppTextStyles.fontFamilyLora,
                    color: isWhite == true
                        ? ColorsBox.brightBlue
                        : ColorsBox.white,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
