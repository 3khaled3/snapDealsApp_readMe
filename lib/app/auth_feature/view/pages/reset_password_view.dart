import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:snap_deals/core/utils/strings_manager.dart';

import '../../model_view/cubit/validation_function.dart';

class ResetPasswordViewArgs {
  //todo add any parameters you need
}

// ignore: must_be_immutable
class ResetPasswordView extends StatelessWidget {
  ResetPasswordView(this.args, {super.key});
  final ResetPasswordViewArgs? args;
  static const String routeName = '/reset_password_route';
  final formKey = GlobalKey<FormState>();
  String? newPassword1;
  String? newPassword2;

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
                    Text(AppStrings.forgotPasswordScreenLabel,
                        style: AppTextStyles.semiBold30().copyWith(
                          fontFamily: AppTextStyles.fontFamilyLora,
                          color: ColorsBox.black,
                        )),
                    42.ph,
                    Text(
                      AppStrings.resetPasswordDiscription,
                      style: AppTextStyles.regular16(),
                      textAlign: TextAlign.center,
                    ),
                    49.4.ph,
                    CustomTextFormField(
                      hintText: AppStrings.hintPassword,
                      labelText: AppStrings.newPasswordLabel,
                      prefixIcon: EvaIcons.lockOutline,
                      isPassword: true,
                      validator: validatePassword,
                      onChanged: (value) {
                        newPassword1 = value;
                      },
                    ),
                    34.ph,
                    CustomTextFormField(
                      hintText: AppStrings.hintPassword,
                      labelText: AppStrings.confirmPasswordLabel,
                      prefixIcon: EvaIcons.lockOutline,
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
                              title: AppStrings.resetPasswordButton,
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
            ],
          ),
        ),
      ),
    );
  }
}
