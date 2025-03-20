import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:snap_deals/core/extensions/sized_box_extension.dart';

import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';

import 'login_view.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  static const routeName = '/onBoard_route';

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          50.ph,
          Container(
            width: 350,
            height: 350,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImageAssets.onboardingImage),
                    fit: BoxFit.cover)),
          ),
          78.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.tr.onBoardingTitle, style: AppTextStyles.bold24()),
              Text(context.tr.appName,
                  style: AppTextStyles.bold24().copyWith(
                    color: ColorsBox.brightBlue,
                    fontFamily: AppTextStyles.fontFamilyLora,
                  )),
            ],
          ),
          29.ph,
          Text(
            index == 0
                ? context.tr.onBoardingSubtitle1
                : index == 1
                    ? context.tr.onBoardingSubtitle2
                    : context.tr.onBoardingSubtitle3,
            style: AppTextStyles.semiBold20(),
            textAlign: TextAlign.center,
          ),
          10.ph,
          Text(
              index == 0
                  ? context.tr.onBoardingDescription1
                  : index == 1
                      ? context.tr.onBoardingDescription2
                      : context.tr.onBoardingDescription3,
              style: AppTextStyles.medium16(),
              textAlign: TextAlign.center),
          const Spacer(
            flex: 2,
          ),
          OutlinedButton(
            onPressed: () {
              if (index < 2) {
                setState(() {
                  index++;
                });
              } else {
                GoRouter.of(context)
                    .push(LoginScreen.routeName, extra: LoginViewArgs());
              }
            },
            style: OutlinedButton.styleFrom(
                shape: const CircleBorder(),
                fixedSize: const Size(66, 66),
                backgroundColor: ColorsBox.brightBlue),
            child: const Center(
              child: Icon(
                Icons.arrow_forward,
                color: ColorsBox.white,
                size: 22,
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
