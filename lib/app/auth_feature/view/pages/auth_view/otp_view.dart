import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/model_view/forget_password_cubit/forget_password_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/reset_password_view.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_button_row.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_otp_text_field.dart';

import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';

class OtpViewArgs {
  //todo add any parameters you need
  final String email;
  OtpViewArgs({required this.email});
}

// ignore: must_be_immutable
class OtpView extends StatelessWidget {
  OtpView(this.args, {super.key});
  final OtpViewArgs? args;
  static const String routeName = '/Otp_route';
  final formKey = GlobalKey<FormState>();
  String? digit;
  TextEditingController digit1Controller = TextEditingController();
  TextEditingController digit2Controller = TextEditingController();
  TextEditingController digit3Controller = TextEditingController();
  TextEditingController digit4Controller = TextEditingController();
  TextEditingController digit5Controller = TextEditingController();
  TextEditingController digit6Controller = TextEditingController();
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
                    Text(context.tr.otpScreenLabel,
                        style: AppTextStyles.semiBold30().copyWith(
                          fontFamily: AppTextStyles.fontFamilyLora,
                          color: ColorsBox.black,
                        )),
                    42.ph,
                    Text(
                      context.tr.otpDescription,
                      style: AppTextStyles.regular16(),
                      textAlign: TextAlign.center,
                    ),
                    40.ph,
                    SizedBox(
                      height: 44,
                      width: 110,
                    ),
                    26.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomOtpTextFormField(
                          onSaved: (p0) => digit = p0,
                          controller: digit1Controller,
                        ),
                        CustomOtpTextFormField(
                          onSaved: (p0) => digit = p0,
                          controller: digit2Controller,
                        ),
                        CustomOtpTextFormField(
                          onSaved: (p0) => digit = p0,
                          controller: digit3Controller,
                        ),
                        CustomOtpTextFormField(
                          onSaved: (p0) => digit = p0,
                          controller: digit4Controller,
                        ),
                        CustomOtpTextFormField(
                          onSaved: (p0) => digit = p0,
                          controller: digit5Controller,
                        ),
                        CustomOtpTextFormField(
                          onSaved: (p0) => digit = p0,
                          controller: digit6Controller,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: double.infinity,
                        child: BlocListener<ForgetPasswordCubit,
                            ForgetPasswordState>(
                          // bloc: forgetPasswordCubit,
                          listener: (context, state) {
                            if (state is SendOtpSuccess) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                context.showSuccessSnackBar(
                                  message: context.tr.send_otp_success,
                                );
                                Navigator.of(context).pop();
                              });
                            } else if (state is SendOtpError) {
                              context.showErrorSnackBar(
                                message: context.tr.send_otp_error,
                              );
                              Navigator.of(context).pop();
                            } else if (state is SendOtpLoading) {
                              context.showLoadingDialog();
                            }
                          },
                          child: TextButton(
                            onPressed: () async {
                              if (args!.email.isNotEmpty) {
                                await BlocProvider.of<ForgetPasswordCubit>(
                                        context)
                                    .sendOTP(email: args!.email);
                              }
                            },
                            child: Text(
                              context.tr.resendCodeButton,
                              style: AppTextStyles.regular16(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    281.ph,
                    SizedBox(
                      width: double.infinity,
                      child: BlocListener<ForgetPasswordCubit,
                          ForgetPasswordState>(
                        // bloc: forgetPasswordCubit,
                        listener: (context, state) {
                          if (state is VerifyOtpSuccess) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              context.showSuccessSnackBar(
                                message: context.tr.verify_otp_success,
                              );
                              GoRouter.of(context).pushReplacement(
                                  ResetPasswordView.routeName,
                                  extra: ResetPasswordViewArgs(
                                      email: args!.email));
                            });
                          } else if (state is VerifyOtpError) {
                            context.showErrorSnackBar(
                              message: context.tr.verify_otp_error,
                            );
                            Navigator.of(context).pop();
                          } else if (state is VerifyOtpLoading) {
                            context.showLoadingDialog();
                          }
                        },
                        child: CustomButtonRow(
                          saveButtonText: context.tr.nextButton,
                          onSave: () async {
                            String otp = digit1Controller.text +
                                digit2Controller.text +
                                digit3Controller.text +
                                digit4Controller.text +
                                digit5Controller.text +
                                digit6Controller.text;
                            if (formKey.currentState?.validate() ?? false) {
                              await BlocProvider.of<ForgetPasswordCubit>(
                                      context)
                                  .verifyOTP(otp: otp);
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