import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
}

// ignore: must_be_immutable
class OtpView extends StatelessWidget {
  OtpView(this.args, {super.key});
  final OtpViewArgs? args;
  static const String routeName = '/Otp_route';
  final formKey = GlobalKey<FormState>();
  String? digit;
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
                        ),
                        CustomOtpTextFormField(
                          onSaved: (p0) => digit = p0,
                        ),
                        CustomOtpTextFormField(
                          onSaved: (p0) => digit = p0,
                        ),
                        CustomOtpTextFormField(
                          onSaved: (p0) => digit = p0,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          context.tr.resendCodeButton,
                          style: AppTextStyles.regular16(),
                        ),
                      ),
                    ),
                    281.ph,
                    CustomButtonRow(
                      saveButtonText: context.tr.nextButton,
                      onSave: () {
                        () {
                          // TODO navigate to reset password screen
                          if (formKey.currentState?.validate() ?? false) {
                            // loginCubit.loginWithEmail(email, password);
                            GoRouter.of(context).push(
                                ResetPasswordView.routeName,
                                extra: ResetPasswordViewArgs());
                          }
                        };
                      },
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
