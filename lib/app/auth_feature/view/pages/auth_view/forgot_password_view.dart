import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/model_view/forget_password_cubit/forget_password_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/otp_view.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_button_row.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:snap_deals/core/utils/validators.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';

class ForgetPasswordViewArgs {
  //todo add any parameters you need
}

// ignore: must_be_immutable
class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView(this.args, {super.key});
  final ForgetPasswordViewArgs? args;
  static const String routeName = '/forget_password_route';
  final formKey = GlobalKey<FormState>();
  String? email;
  final TextEditingController emailController = TextEditingController();
  // ForgetPasswordCubit forgetPasswordCubit = ForgetPasswordCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsBox.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * .56,
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * .08,
                    left: 28,
                    right: 28),
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
                  style: AppTextStyles.bold34().copyWith(
                      fontFamily: context.tr.fontFamilyLora,
                      color: ColorsBox.white),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * .18, bottom: 8),
                padding: const EdgeInsets.only(left: 28, right: 28),
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
                          fontFamily: context.tr.fontFamilyLora,
                          color: ColorsBox.black,
                        )),
                    42.ph,
                    Text(
                      context.tr.forgotPasswordDescription,
                      style: AppTextStyles.regular16(),
                      textAlign: TextAlign.center,
                    ),
                    49.ph,
                    CustomTextFormField(
                      hintText: context.tr.hintEmail,
                      labelText: context.tr.emailLabel,
                      prefixIcon: Icons.email_outlined,
                      controller: emailController,
                      validator: Validators.validateEmail,
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    49.ph,
                    SizedBox(
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
                              GoRouter.of(context).pushReplacement(
                                  OtpView.routeName,
                                  extra:
                                      OtpViewArgs(email: emailController.text));
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
                        child: CustomButtonRow(
                          saveButtonText: context.tr.sendButtonLabel,
                          onSave: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              await BlocProvider.of<ForgetPasswordCubit>(
                                      context)
                                  .sendOTP(email: emailController.text);
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
