import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/forgot_password_view.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/login_view.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_button_row.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';
import 'package:snap_deals/app/home_feature/view_model/test_cubit/test_cubit.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/hive_helper.dart';
import 'package:snap_deals/core/utils/validators.dart';

class CustomBottomSheet {
  static void showLogoutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 24,
          right: 24,
        ),
        child: SizedBox(
          height: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Sheet drag handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              24.ph,
              Text(
                context.tr.logOut,
                style: AppTextStyles.bold20().copyWith(color: ColorsBox.black),
              ),
              16.ph,
              Text(
                context.tr.logOutHint,
                textAlign: TextAlign.center,
                style:
                    AppTextStyles.medium16().copyWith(color: ColorsBox.grey700),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: buildButton(
                      text: context.tr.cancelWord,
                      textColor: ColorsBox.brightBlue,
                      borderColor: ColorsBox.brightBlue,
                      onTap: () => GoRouter.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: buildButton(
                      text: context.tr.logOutButtonLabel,
                      textColor: ColorsBox.white,
                      backgroundColor: ColorsBox.brightBlue,
                      onTap: () {
                        GoRouter.of(context).push(LoginScreen.routeName);
                      },
                    ),
                  ),
                ],
              ),
              20.ph,
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildButton({
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
          borderRadius: BorderRadius.circular(24),
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
    final currentPasswordController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (testContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 28,
            right: 28,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: formKey,
            child: SizedBox(
              height: 320,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  24.ph,
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  24.ph,
                  Text(
                    testContext.tr.passwordManager,
                    style: AppTextStyles.medium20()
                        .copyWith(color: ColorsBox.black),
                  ),
                  25.ph,
                  CustomTextFormField(
                    hintText: testContext.tr.currentPassword,
                    labelText: testContext.tr.currentPassword,
                    controller: currentPasswordController,
                    isPassword: true,
                    validator: (String? value) {
                      final password = HiveHelper.instance.getItem("password");
                      if (value == null || value.isEmpty || value != password) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        GoRouter.of(testContext).push(
                          ForgetPasswordView.routeName,
                          extra: ForgetPasswordViewArgs(),
                        );
                      },
                      child: Text(
                        testContext.tr.forgotPasswordButton,
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
                        if (formKey.currentState!.validate()) {
                          Navigator.of(testContext).pop();
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (_) => BlocProvider.value(
                                value: ProfileCubit.instance,
                                child: Builder(
                                  builder: (newContext) =>
                                      showChangePasswordSheet(newContext),
                                ),
                              ),
                            );
                          });
                        }
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget showChangePasswordSheet(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final newPassword1Controller = TextEditingController();
    final newPassword2Controller = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        left: 28,
        right: 28,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 20,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 4,
              padding: EdgeInsets.only(
                left: 28,
                right: 28,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                top: 20,
              ),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              context.tr.passwordManager,
              style: AppTextStyles.medium20().copyWith(color: ColorsBox.black),
            ),
            25.ph,
            CustomTextFormField(
              hintText: context.tr.hintPassword,
              labelText: context.tr.newPasswordLabel,
              controller: newPassword1Controller,
              isPassword: true,
              validator: Validators.validatePassword,
            ),
            24.ph,
            CustomTextFormField(
              hintText: context.tr.hintPassword,
              labelText: context.tr.confirmPasswordLabel,
              controller: newPassword2Controller,
              isPassword: true,
              validator: (String? value) {
                final password = newPassword2Controller.text;
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else if (value != password) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            25.ph,
            SizedBox(
              width: double.infinity,
              child: BlocListener<ProfileCubit, ProfileStates>(
                listener: (context, state) {
                  if (state is ProfileSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.showSuccessSnackBar(
                        message: 'Password changed successfully',
                      );
                      HiveHelper.instance
                          .addItem("password", newPassword2Controller.text);
                      GoRouter.of(context).pushReplacement(
                        MainHomeView.routeName,
                        extra: MainHomeViewArgs(),
                      );
                    });
                  } else if (state is ProfileError) {
                    context.showErrorSnackBar(message: "Something went wrong");
                    Navigator.of(context).pop();
                  } else if (state is ProfileLoading) {
                    context.showLoadingDialog();
                  }
                },
                child: CustomButtonRow(
                  saveButtonText: context.tr.resetPasswordButton,
                  onSave: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      await ProfileCubit.instance.changePassword(
                        newPassword: newPassword2Controller.text,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
