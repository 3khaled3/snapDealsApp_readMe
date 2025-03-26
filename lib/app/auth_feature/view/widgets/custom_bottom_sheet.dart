import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/pages/forgot_password_view.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
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
              'Password Manager',
              style: AppTextStyles.medium20().copyWith(color: ColorsBox.black),
            ),
            25.ph,
            const CustomTextFormField(
              hintText: "Current Password",
              labelText: "Current Password",
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
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 20),
                    shape: const CircleBorder(),
                    fixedSize: const Size(66, 66),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: ColorsBox.brightBlue,
                    size: 26,
                  ),
                ),
                10.pw,
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomPrimaryButton(
                      title: context.tr.nextButton,
                      onTap: () {
                        if (formKey.currentState?.validate() ?? false) {
                          // loginCubit.loginWithEmail(email, password);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
