import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/pages/reset_password_view.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_otp_text_field.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';

import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:snap_deals/core/utils/strings_manager.dart';

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
                padding: const EdgeInsets.only(top: 82, left: 28),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      AppImageAssets.authImage,
                    ),
                  ),
                ),
                child: Text(
                  AppStrings.appName,
                  style: AppTextStyles.bold42().copyWith(
                      fontFamily: AppTextStyles.fontFamilyLora,
                      color: ColorsBox.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 167),
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
                    Text(AppStrings.otpScreenLabel,
                        style: AppTextStyles.semiBold30().copyWith(
                          fontFamily: AppTextStyles.fontFamilyLora,
                          color: ColorsBox.black,
                        )),
                    42.ph,
                    Text(
                      AppStrings.otpDiscription,
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
                          AppStrings.sendAgainButton,
                          style: AppTextStyles.regular16(),
                        ),
                      ),
                    ),
                    281.ph,
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
                          ),
                        ),
                        10.pw,
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: CustomPrimaryButton(
                              title: AppStrings.nextButton,
                              onTap: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  // loginCubit.loginWithEmail(email, password);
                                  GoRouter.of(context).push(
                                      ResetPasswordView.routeName,
                                      extra: ResetPasswordViewArgs());
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
            ],
          ),
        ),
      ),
    );
  }
}
