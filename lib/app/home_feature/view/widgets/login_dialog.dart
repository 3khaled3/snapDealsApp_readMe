import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

customAppDialog({
  required BuildContext context,
  required String title,
  required String supTitle,
  required String buttonTitle,
  required String cancelButtonTitle,
  bool showCancelButton = false,
  Color? confirmColor,
  required Function() onPressed,
}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: !showCancelButton
              ? Text(
                  title,
                  style: AppTextStyles.bold20(),
                )
              : Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: GestureDetector(
                        child: const Icon(Icons.close,
                            color: ColorsBox.brightBlue),
                        onTap: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ),
                    Text(
                      title,
                      style: AppTextStyles.bold20(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
          content: Text(
            supTitle,
            style: AppTextStyles.regular16().copyWith(color: ColorsBox.black),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
          actions: [
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomElevatedButton(
                    buttonTitle: buttonTitle,
                    onPressed: onPressed,
                    confirmColor: confirmColor,
                  ),
                  10.ph,
                  CustomOutlinedButton(buttonTitle: cancelButtonTitle),
                  18.ph,
                ],
              ),
            ),
          ],
        );
      },
    );
  });
}

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.buttonTitle,
  });
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        GoRouter.of(context).pop();
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        side: const BorderSide(color: ColorsBox.brightBlue, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        buttonTitle,
        style: AppTextStyles.bold16().copyWith(color: ColorsBox.brightBlue),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.buttonTitle,
    this.confirmColor,
    required this.onPressed,
  });
  final String buttonTitle;
  final Color? confirmColor;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: confirmColor ?? ColorsBox.brightBlue,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        buttonTitle,
        style: AppTextStyles.bold16().copyWith(color: ColorsBox.white),
      ),
    );
  }
}
