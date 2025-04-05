import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:snap_deals/core/utils/validators.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/text_styles.dart';

import '../../widgets/custom_primary_button.dart';
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
  String? name;
  String? email;
  String? password;
  String? number;
  String? address;
  String gender = 'male';
  String? age;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final separator = (MediaQuery.sizeOf(context).height * .036).ph;
    return Scaffold(
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
                style: AppTextStyles.bold42().copyWith(
                    fontFamily: AppTextStyles.fontFamilyLora,
                    color: ColorsBox.white),
              ),
            ),
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * .11, bottom: 8),
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
                        style: AppTextStyles.semiBold30().copyWith(
                            fontFamily: AppTextStyles.fontFamilyLora)),
                    separator,
                    CustomTextFormField(
                      hintText: context.tr.yourName,
                      labelText: context.tr.Name,
                      prefixIcon: EvaIcons.person,
                      validator: Validators.validateEmail,
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                    separator,
                    CustomTextFormField(
                      hintText: context.tr.hintEmail,
                      labelText: context.tr.emailLabel,
                      prefixIcon: EvaIcons.emailOutline,
                      validator: Validators.validateEmail,
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    separator,
                    CustomTextFormField(
                      hintText: context.tr.hintPassword,
                      labelText: context.tr.passwordLoginLabel,
                      prefixIcon: EvaIcons.lockOutline,
                      isPassword: true,
                      validator: Validators.validatePassword,
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    separator,
                    CustomTextFormField(
                      hintText: context.tr.yourNumber,
                      labelText: context.tr.Number,
                      prefixIcon: EvaIcons.hashOutline,
                      validator: Validators.validateNumber,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        number = value;
                      },
                    ),
                    // 34.4.ph,
                    // CustomTextFormField(
                    //   hintText: context.tr.yourAge,
                    //   labelText: context.tr.Age,
                    //   prefixIcon: EvaIcons.calendarOutline,
                    //   validator: Validators.validateAge,
                    //   keyboardType: TextInputType.number,
                    //   onChanged: (value) {
                    //     age = value;
                    //   },
                    // ),
                    separator,
                    CustomTextFormField(
                      hintText: context.tr.yourAddress,
                      labelText: context.tr.Address,
                      prefixIcon: EvaIcons.pinOutline,
                      validator: Validators.validateAddress,
                      onChanged: (value) {
                        address = value;
                      },
                    ),
                    // 32.1.ph,
                    // Container(
                    //   padding: const EdgeInsets.only(
                    //     left: 22,
                    //     right: 22,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     border: Border.all(
                    //       color: ColorsBox.paleGrey,
                    //     ),
                    //     borderRadius: BorderRadius.circular(16),
                    //   ),
                    //   child: DropdownButton<String>(
                    //       items: [
                    //         DropdownMenuItem<String>(
                    //             value: 'male', child: Text(context.tr.male)),
                    //         DropdownMenuItem<String>(
                    //             value: 'female', child: Text(context.tr.female))
                    //       ],
                    //       value: gender,
                    //       underline: Container(
                    //         color: Colors.white,
                    //       ),
                    //       menuWidth: 373,
                    //       isExpanded: true,
                    //       style: AppTextStyles.regular16()
                    //           .copyWith(color: ColorsBox.slateGrey),
                    //       icon: Icon(
                    //         gender == 'male'
                    //             ? Icons.male_outlined
                    //             : Icons.female_outlined,
                    //         color: ColorsBox.brightBlue,
                    //       ),
                    //       onChanged: (String? value) {
                    //         setState(() {
                    //           gender = value!;
                    //         });
                    //       }),
                    // ),
                    separator,
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
                              title: context.tr.registerButton,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 66.pw,
                        OutlinedButton(
                          onPressed: () {
                            // Handle login
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            backgroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                          ),
                          child: const Icon(
                            Icons.apple,
                            color: Colors.black,
                            size: 32,
                          ),
                        ),
                        13.pw,
                        OutlinedButton(
                            onPressed: () {
                              // Handle login
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              backgroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                            ),
                            child: const Icon(
                              EvaIcons.google,
                              color: Color(0xffd62d20),
                              size: 32,
                            )),
                        13.pw,
                        OutlinedButton(
                          onPressed: () {
                            // Handle login
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            backgroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                          ),
                          child: const Icon(
                            Icons.facebook,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        // 66.pw,
                      ],
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
