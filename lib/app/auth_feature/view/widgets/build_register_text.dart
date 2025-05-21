import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/register_view.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
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
          context.tr.registerLabel,
          style:
              AppTextStyles.semiBold14().copyWith(color: ColorsBox.slateGrey),
        ),
        TextButton(
          onPressed: () {
            GoRouter.of(context)
                .push(RegisterView.routeName, extra: RegisterViewArgs());
          },
          child: Text(
            context.tr.createAccount,
            style: AppTextStyles.bold14().copyWith(
                color: ColorsBox.brightBlue,
                fontFamily: context.tr.fontFamilyLora),
          ),
        ),
      ],
    );
  }
}
