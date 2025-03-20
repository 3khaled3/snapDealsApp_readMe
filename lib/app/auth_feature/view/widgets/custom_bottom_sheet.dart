import 'package:flutter/material.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomBottomSheet {
  static void showLogoutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(55),
          topRight: Radius.circular(55),
        ),
      ),
      builder: (context) => Container(
        height: 240,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(55),
            topRight: Radius.circular(55),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 36),
            Text(
              'Log out',
              style: AppTextStyles.medium20().copyWith(color: ColorsBox.black),
            ),
            const SizedBox(height: 28),
            Text(
              'Are you sure you want to log out?',
              style:
                  AppTextStyles.medium18().copyWith(color: ColorsBox.greyish),
            ),
            const SizedBox(height: 47),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildButton(
                    text: 'Cancel',
                    textColor: ColorsBox.brightBlue,
                    borderColor: ColorsBox.brightBlue,
                    onTap: () => Navigator.pop(context),
                  ),
                  _buildButton(
                    text: 'Yes, Logout',
                    textColor: ColorsBox.white,
                    backgroundColor: ColorsBox.brightBlue,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildButton({
    required String text,
    required Color textColor,
    Color? backgroundColor,
    Color? borderColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 135,
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(55),
          border: borderColor != null ? Border.all(color: borderColor) : null,
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.medium18().copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
