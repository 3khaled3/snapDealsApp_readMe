import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(999999),
            onTap: () => GoRouter.of(context).pop(),
            // style: OutlinedButton.styleFrom(
            //   shape: const CircleBorder(),
            //   // fixedSize: const Size(66, 66),
            // ),
            child: Ink(
              decoration: BoxDecoration(
                color: ColorsBox.white,
                borderRadius: BorderRadius.circular(999999),
                border: Border.all(color: ColorsBox.greyish, width: 1),
              ),
              padding: const EdgeInsets.all(12),
              child: Container(
                // color: Colors.red,
                padding: const EdgeInsetsDirectional.only(
                    start: 8, top: 4, bottom: 4),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorsBox.brightBlue,
                  // size: 25,
                ),
              ),
            ),
          ),
        ),
        14.pw,
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

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999999),
        onTap: () => GoRouter.of(context).pop(),
        // style: OutlinedButton.styleFrom(
        //   shape: const CircleBorder(),
        //   // fixedSize: const Size(66, 66),
        // ),
        child: Ink(
          decoration: BoxDecoration(
            color: ColorsBox.white,
            borderRadius: BorderRadius.circular(999999),
            border: Border.all(color: ColorsBox.greyish, width: 1),
          ),
          padding: const EdgeInsets.all(8),
          child: Container(
            // color: Colors.red,
            padding:
                const EdgeInsetsDirectional.only(start: 8, top: 4, bottom: 4),
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorsBox.brightBlue,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
