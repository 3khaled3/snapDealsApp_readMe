import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/forgot_password_view.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/login_view.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_button_row.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';
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
                        ProfileCubit.instance.logoutUser();
                        while (GoRouter.of(context).canPop()) {
                          GoRouter.of(context).pop();
                        }
                        GoRouter.of(context).pushReplacement(
                          LoginScreen.routeName,
                        );
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

    final newPassword1Controller = TextEditingController();
    final newPassword2Controller = TextEditingController();

    bool isVerifyingCurrentPassword = true;
    bool obscureTextCurrent = true;
    bool obscureText1 = true;
    bool obscureText2 = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (ctx) {
        // هنا بنوفر الـ ProfileCubit بشكل محلي داخل البوتوم شيت
        return BlocProvider.value(
          value: ProfileCubit.instance, // أو .create إذا انت بتستخدم create
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 28,
                  right: 28,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
                  top: 20,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Text(
                          ctx.tr.passwordManager,
                          style: AppTextStyles.medium20()
                              .copyWith(color: ColorsBox.black),
                        ),
                        25.ph,
                        if (isVerifyingCurrentPassword) ...[
                          TextFormField(
                            controller: currentPasswordController,
                            obscureText: obscureTextCurrent,
                            decoration: InputDecoration(
                              labelText: ctx.tr.currentPassword,
                              hintText: ctx.tr.currentPassword,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureTextCurrent
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscureTextCurrent = !obscureTextCurrent;
                                  });
                                },
                              ),
                            ),
                            validator: (String? value) {
                              final password =
                                  HiveHelper.instance.getItem("password");
                              if (value == null ||
                                  value.isEmpty ||
                                  value != password) {
                                return context.tr.currentPassword_error;
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                GoRouter.of(ctx).push(
                                  ForgetPasswordView.routeName,
                                  extra: ForgetPasswordViewArgs(),
                                );
                              },
                              child: Text(
                                ctx.tr.forgotPasswordButton,
                                style: AppTextStyles.medium14().copyWith(
                                  color: ColorsBox.brightBlue,
                                ),
                              ),
                            ),
                          ),
                          25.ph,
                          CustomButtonRow(
                            saveButtonText: ctx.tr.nextButton,
                            onSave: () {
                              if (formKey.currentState?.validate() ?? false) {
                                setState(() {
                                  isVerifyingCurrentPassword = false;
                                  formKey.currentState?.reset();
                                });
                              }
                            },
                          ),
                        ] else ...[
                          TextFormField(
                            controller: newPassword1Controller,
                            obscureText: obscureText1,
                            decoration: InputDecoration(
                              labelText: ctx.tr.newPasswordLabel,
                              hintText: ctx.tr.hintPassword,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureText1
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscureText1 = !obscureText1;
                                  });
                                },
                              ),
                            ),
                            validator:  Validators.validatePassword,
                            //  (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return ctx.tr.password_validate;
                            //   } else if (value.length < 6) {
                            //     return ctx.tr.password_validate2;
                            //   }
                            //   return null;
                            // },
                          ),
                          24.ph,
                          TextFormField(
                            controller: newPassword2Controller,
                            obscureText: obscureText2,
                            decoration: InputDecoration(
                              labelText: ctx.tr.confirmPasswordLabel,
                              hintText: ctx.tr.hintPassword,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureText2
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscureText2 = !obscureText2;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ctx.tr.resetPasswordDescription;
                              } else if (value != newPassword1Controller.text) {
                                return ctx.tr.currentPassword_error;
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
                                    Navigator.of(context)
                                        .pop(); // اقفل الـ bottom sheet
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            context.tr.password_change_success),
                                        backgroundColor: ColorsBox.green,
                                      ),
                                    );
                                    HiveHelper.instance.addItem("password",
                                        newPassword2Controller.text);
                                    GoRouter.of(context).pushReplacement(
                                      MainHomeView.routeName,
                                      extra: MainHomeViewArgs(),
                                    );
                                  } else if (state is ProfileError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(context.tr.error_load),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  } else if (state is ProfileLoading) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (_) => Center(
                                        child: LoadingAnimationWidget
                                            .threeArchedCircle(
                                          color: ColorsBox.mainColor,
                                          size: 40,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: CustomPrimaryButton(
                                  title: ctx.tr.saveButton,
                                  onTap: () async {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      await ProfileCubit.instance
                                          .changePassword(
                                        newPassword:
                                            newPassword2Controller.text,
                                      );
                                      Navigator.of(context).pop();
                                    }
                                  },
                                )),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
