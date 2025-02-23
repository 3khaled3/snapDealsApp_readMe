import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/pages/register_view.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class BuildRegisterText extends StatelessWidget {
  const BuildRegisterText({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "new to ?",
          style: AppTextStyles.light16().copyWith(
            color: ColorsBox.black,
          ),
        ),
        TextButton(
          onPressed: () {
            GoRouter.of(context)
                .push(RegisterView.routeName, extra: RegisterViewArgs());
          },
          child: Text(
            "Create an account",
            style: AppTextStyles.medium16().copyWith(
                color: ColorsBox.brightBlue,
                fontFamily: AppTextStyles.fontFamilyLora),
          ),
        ),
      ],
    );
  }
}
