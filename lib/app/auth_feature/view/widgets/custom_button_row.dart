import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/core/themes/app_colors.dart';

class CustomButtonRow extends StatelessWidget {
  final String saveButtonText;
  final VoidCallback? onSave;

  const CustomButtonRow({
    super.key,
    required this.saveButtonText,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () => GoRouter.of(context).pop(),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
            shape: const CircleBorder(),
            fixedSize: const Size(66, 66),
          ),
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorsBox.brightBlue,
            size: 25,
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: CustomPrimaryButton(
            title: saveButtonText,
            onTap: onSave!,
          ),
        ),
      ],
    );
  }
}
