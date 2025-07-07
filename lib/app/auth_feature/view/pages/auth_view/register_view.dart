import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_button_row.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:snap_deals/core/utils/validators.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/text_styles.dart';

import '../../widgets/custom_text_field.dart';

class RegisterViewArgs {
  //todo add any parameters you need
}

class RegisterView extends StatefulWidget {
  const RegisterView(this.args, {super.key});
  final RegisterViewArgs args;
  static const String routeName = '/register_route';
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final separator = (16).ph;
    return Scaffold(
      backgroundColor: ColorsBox.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Stack(children: [
            Container(
              height: MediaQuery.sizeOf(context).height * .56,
              width: MediaQuery.sizeOf(context).width,
              padding: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * .05,
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
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * .1, bottom: 8),
                padding: const EdgeInsets.only(left: 28, right: 29),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(55),
                        topRight: Radius.circular(55))),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    separator,
                    Text(context.tr.createAccount,
                        style: AppTextStyles.semiBold24()
                            .copyWith(fontFamily: context.tr.fontFamilyLora)),
                    separator,
                    CustomTextFormField(
                      hintText: context.tr.yourName,
                      labelText: context.tr.Name,
                      prefixIcon: EvaIcons.person,
                      // validator: Validators.validateEmail,
                      controller: nameController,
                    ),
                    separator,
                    CustomTextFormField(
                      hintText: context.tr.hintEmail,
                      labelText: context.tr.emailLabel,
                      prefixIcon: EvaIcons.emailOutline,
                      validator: Validators.validateEmail,
                      controller: emailController,
                    ),
                    separator,
                    CustomTextFormField(
                      hintText: context.tr.hintPassword,
                      labelText: context.tr.passwordLoginLabel,
                      prefixIcon: EvaIcons.lockOutline,
                      isPassword: true,
                      // validator: Validators.validatePassword,
                      controller: passwordController,
                    ),
                    separator,
                    CustomTextFormField(
                      hintText: context.tr.yourNumber,
                      labelText: context.tr.Number,
                      prefixIcon: EvaIcons.hashOutline,
                      // validator: Validators.validateNumber,
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                    ),
                    separator,

                    BlocListener<ProfileCubit, ProfileStates>(
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
                      child: CustomButtonRow(
                        saveButtonText: context.tr.registerButton,
                        onSave: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            await ProfileCubit.instance.registerUser(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text);
                          }
                        },
                      ),
                    ),
                    // Spacer(),

                    (MediaQuery.sizeOf(context).height * .02).ph,
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
                            padding: const EdgeInsets.symmetric(horizontal: 12),
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
            ),
          ]),
        ),
      ),
    );
  }
}
