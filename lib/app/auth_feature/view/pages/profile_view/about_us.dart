import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  static const String routeName = '/about_us_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 70,
          right: 7,
          left: 7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            48.ph,
            Text(
              context.tr.onBoardingSubtitle1,
              style: AppTextStyles.semiBold20(),
            ),
            15.ph,
            Text(
              context.tr.onBoardingDescription1,
              style: AppTextStyles.medium16(),
              textAlign: TextAlign.center,
            ),
            47.ph,
            Text(
              context.tr.onBoardingSubtitle2,
              style: AppTextStyles.semiBold20(),
            ),
            15.ph,
            Text(
              context.tr.onBoardingDescription2,
              style: AppTextStyles.medium16(),
              textAlign: TextAlign.center,
            ),
            47.ph,
            Text(
              context.tr.onBoardingSubtitle3,
              style: AppTextStyles.semiBold20(),
            ),
            15.ph,
            Text(
              context.tr.onBoardingDescription3,
              style: AppTextStyles.medium16(),
              textAlign: TextAlign.center,
            ),
            60.ph,
            OutlinedButton(
              onPressed: () => GoRouter.of(context).pop(),
              style: OutlinedButton.styleFrom(
                shape: const CircleBorder(),
                fixedSize: const Size(66, 66),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: ColorsBox.brightBlue,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
