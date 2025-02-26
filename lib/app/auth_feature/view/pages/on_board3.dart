import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/pages/login_view.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/localization/generated/l10n.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class OnBoard3ScreenArgs {}

class OnBoard3Screen extends StatelessWidget {
  const OnBoard3Screen(this.args, {super.key});
  final OnBoard3ScreenArgs? args;
  static const routeName = '/onBoard3_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 22.5, right: 22.5),
        child: Column(
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
            Text(
              Tr.current.onBoardingSubtitle3,
              style: AppTextStyles.semiBold20(),
              textAlign: TextAlign.center,
            ),
            33.ph,
            Text(Tr.current.onBoardingDescription3,
                style: AppTextStyles.medium16(), textAlign: TextAlign.center),
            90.ph,
            OutlinedButton(
              onPressed: () {
                GoRouter.of(context)
                    .push(LoginScreen.routeName, extra: LoginViewArgs());
              },
              style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                  shape: const CircleBorder(),
                  fixedSize: const Size(66, 66),
                  backgroundColor: ColorsBox.brightBlue),
              child: const Icon(
                Icons.arrow_forward,
                color: ColorsBox.white,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
