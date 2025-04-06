import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/core/themes/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => GoRouter.of(context).pop(),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
        shape: const CircleBorder(),
        fixedSize: const Size(66, 66),
        backgroundColor: ColorsBox.white,
      ),
      child: const Icon(
        Icons.arrow_back_ios,
        color: ColorsBox.brightBlue,
        size: 25,
      ),
    );
  }
}
