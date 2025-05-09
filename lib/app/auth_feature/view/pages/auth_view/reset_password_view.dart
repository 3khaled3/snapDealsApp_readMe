import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/model_view/forget_password_cubit/forget_password_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/login_view.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_button_row.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:snap_deals/core/utils/validators.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';

class ResetPasswordViewArgs {
  //todo add any parameters you need
  final String email;

  ResetPasswordViewArgs({required this.email});
}

// ignore: must_be_immutable
class ResetPasswordView extends StatelessWidget {
  ResetPasswordView(this.args, {super.key});
  final ResetPasswordViewArgs? args;
  static const String routeName = '/reset_password_route';
  final formKey = GlobalKey<FormState>();
  String? newPassword1;
  String? newPassword2;
  TextEditingController newPassword1Controller = TextEditingController();
  TextEditingController newPassword2Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Stack(
            children: [
              Container(
                height: 216,
                width: MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.only(top: 82, left: 28, right: 28),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      AppImageAssets.authImage,
                    ),
                  ),
                ),
                child: Text(
                  context.tr.appName,
                  style: AppTextStyles.bold42().copyWith(
                      fontFamily: AppTextStyles.fontFamilyLora,
                      color: ColorsBox.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 167, bottom: 8),
                padding: const EdgeInsets.only(left: 28, right: 29),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(55),
                        topRight: Radius.circular(55))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    33.ph,
                    Container(
                      width: 218,
                      height: 153,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AppImageAssets.forgotPassImage),
                            fit: BoxFit.cover),
                      ),
                    ),
                    27.ph,
                    Text(context.tr.forgotPasswordScreenLabel,
                        style: AppTextStyles.semiBold30().copyWith(
                          fontFamily: AppTextStyles.fontFamilyLora,
                          color: ColorsBox.black,
                        )),
                    42.ph,
                    Text(
                      context.tr.resetPasswordDescription,
                      style: AppTextStyles.regular16(),
                      textAlign: TextAlign.center,
                    ),
                    49.4.ph,
                    CustomTextFormField(
                      hintText: context.tr.hintPassword,
                      labelText: context.tr.newPasswordLabel,
                      prefixIcon: EvaIcons.lockOutline,
                      controller: newPassword1Controller,
                      isPassword: true,
                      validator: Validators.validatePassword,
                      onChanged: (value) {
                        newPassword1 = value;
                      },
                    ),
                    34.ph,
                    CustomTextFormField(
                      hintText: context.tr.hintPassword,
                      labelText: context.tr.confirmPasswordLabel,
                      prefixIcon: EvaIcons.lockOutline,
                      controller: newPassword2Controller,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please re-enter your password';
                        } else if (value != newPassword1) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        newPassword2 = value;
                      },
                    ),
                    114.ph,
                    SizedBox(
                      width: double.infinity,
                      child: BlocListener<ForgetPasswordCubit,
                          ForgetPasswordState>(
                        // bloc: forgetPasswordCubit,
                        listener: (context, state) {
                          if (state is SavePasswordSuccess) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              context.showSuccessSnackBar(
                                message: context.tr.reset_password_success,
                              );
                              GoRouter.of(context).pushReplacement(
                                  LoginScreen.routeName,
                                  extra: LoginViewArgs());
                            });
                          } else if (state is SavePasswordError) {
                            context.showErrorSnackBar(
                              message: context.tr.reset_password_error,
                            );
                            Navigator.of(context).pop();
                          } else if (state is SavePasswordLoading) {
                            context.showLoadingDialog();
                          }
                        },
                        child: CustomButtonRow(
                          saveButtonText: context.tr.resetPasswordButton,
                          onSave: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              await BlocProvider.of<ForgetPasswordCubit>(
                                      context)
                                  .newPassword(
                                email: args!.email,
                                newPassword: newPassword1Controller.text,
                              );
                              print(newPassword1Controller.text);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}