import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/forgot_password_view.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/login_view.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_button_row.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/validators.dart';

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
            36.ph,
            Text(
              context.tr.logOut,
              style: AppTextStyles.medium20().copyWith(color: ColorsBox.black),
            ),
            28.ph,
            Text(
              context.tr.logOutHint,
              style:
                  AppTextStyles.medium18().copyWith(color: ColorsBox.greyish),
            ),
            47.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildButton(
                    text: context.tr.cancelWord,
                    textColor: ColorsBox.brightBlue,
                    borderColor: ColorsBox.brightBlue,
                    onTap: () => GoRouter.of(context).pop(),
                  ),
                  _buildButton(
                    text: context.tr.logOutButtonLabel,
                    textColor: ColorsBox.white,
                    backgroundColor: ColorsBox.brightBlue,
                    onTap: () =>
                        GoRouter.of(context).push(LoginScreen.routeName),
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
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(55),
          border: borderColor != null ? Border.all(color: borderColor) : null,
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: AppTextStyles.medium18().copyWith(color: textColor),
          ),
        ),
      ),
    );
  }

  static void showPasswordManagerSheet(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(55),
          topRight: Radius.circular(55),
        ),
      ),
      builder: (context) => Container(
        height: 300,
        width: double.infinity,
        padding: const EdgeInsets.only(left: 28, right: 28),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(55),
            topRight: Radius.circular(55),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            23.ph,
            Text(
              context.tr.passwordManager,
              style: AppTextStyles.medium20().copyWith(color: ColorsBox.black),
            ),
            25.ph,
            CustomTextFormField(
              hintText: context.tr.currentPassword,
              labelText: context.tr.currentPassword,
              isPassword: true,
              validator: Validators.validatePassword,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  GoRouter.of(context).push(ForgetPasswordView.routeName,
                      extra: ForgetPasswordViewArgs());
                },
                child: Text(
                  context.tr.forgotPasswordButton,
                  style: AppTextStyles.medium14().copyWith(
                    color: ColorsBox.brightBlue,
                  ),
                ),
              ),
            ),
            25.ph,
            CustomButtonRow(
              saveButtonText: context.tr.nextButton,
              onSave: () {
                if (formKey.currentState?.validate() ?? false) {
                  GoRouter.of(context).push(MainHomeView.routeName);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
