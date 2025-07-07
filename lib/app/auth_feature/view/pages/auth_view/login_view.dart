import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';

import 'package:snap_deals/app/auth_feature/view/widgets/build_register_text.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:snap_deals/core/utils/validators.dart';
import '../../widgets/custom_text_field.dart';
import 'forgot_password_view.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';

class LoginViewArgs {
  //todo add any parameters you need
}

class LoginScreen extends StatefulWidget {
  const LoginScreen(this.args, {super.key});
  final LoginViewArgs? args;
  static const String routeName = '/login_route';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsBox.white,
      body: SingleChildScrollView(
        child: SizedBox(
          // height: MediaQuery.sizeOf(context).height,
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
                    // mainAxisAlignment: MainAxisAlignment.,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 33.ph,
                      30.ph,

                      Text(context.tr.loginScreenLabel,
                          style: AppTextStyles.semiBold24()
                              .copyWith(fontFamily: context.tr.fontFamilyLora)),
                      30.ph,
                      Text(
                        context.tr.loginLabel,
                        style: AppTextStyles.regular16(),
                      ),
                      18.ph,
                      CustomTextFormField(
                        hintText: context.tr.hintEmail,
                        controller: emailController,
                        labelText: context.tr.emailLabel,
                        prefixIcon: EvaIcons.emailOutline,
                        validator: Validators.validateEmail,
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                      16.ph,
                      CustomTextFormField(
                        hintText: context.tr.hintPassword,
                        controller: passwordController,
                        labelText: context.tr.passwordLoginLabel,
                        prefixIcon: EvaIcons.lockOutline,
                        isPassword: true,
                        validator: Validators.validatePassword,
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      16.ph,
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                          onPressed: () {
                            GoRouter.of(context).push(
                                ForgetPasswordView.routeName,
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
                      16.ph,
                      SizedBox(
                        width: double.infinity,
                        child: BlocListener<ProfileCubit, ProfileStates>(
                          bloc: ProfileCubit.instance,
                          listener: (context, state) {
                            if (state is ProfileSuccess) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                // context.showSuccessSnackBar(
                                //   message: context.tr.loginSuccess,
                                // );
                                GoRouter.of(context).pushReplacement(
                                    MainHomeView.routeName,
                                    extra: MainHomeViewArgs());
                              });
                            } else if (state is ProfileError) {
                              context.showErrorSnackBar(
                                message: context.tr.loginError,
                              );
                              Navigator.of(context).pop();
                            } else if (state is ProfileLoading) {
                              context.showLoadingDialog();
                            }
                          },
                          child: CustomPrimaryButton(
                            title: context.tr.loginButton,
                            onTap: () async {
                              if (formKey.currentState?.validate() ?? false) {
                                await ProfileCubit.instance.loginUser(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                          ),
                        ),
                      ),
                      18.ph,
                      const Center(
                        child: BuildRegisterText(),
                      ),
                      18.ph,

                      Padding(
                        padding: const EdgeInsets.only(left: 80, right: 80),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                                child: Divider(
                              thickness: 2,
                              color: Colors.black,
                            )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                context.tr.orWord,
                                style: AppTextStyles.regular16(),
                              ),
                            ),
                            const Expanded(
                                child: Divider(
                              thickness: 2,
                              color: Colors.black,
                            )),
                          ],
                        ),
                      ),
                      13.ph,
                      Center(
                        child: TextButton(
                          onPressed: () {
                            GoRouter.of(context).pushReplacement(
                              MainHomeView.routeName,
                              extra: MainHomeViewArgs(),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(color: Colors.black12),
                            ),
                          ),
                          child: Text(
                            context.tr.continueAsGuest,
                            style: AppTextStyles.medium14()
                                .copyWith(color: Colors.black54),
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
      ),
    );
  }
}
