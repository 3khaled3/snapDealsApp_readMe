import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/login_view.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';
import 'package:snap_deals/app/on_board_feature/view/on_boarding_view.dart';

import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';
import 'package:snap_deals/core/utils/hive_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final firstTime = HiveHelper.instance.getItem("firstTime");

      if (firstTime == null || firstTime == "false") {
        HiveHelper.instance.addItem("firstTime", "true");

        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            GoRouter.of(context).pushReplacement(OnBoardScreen.routeName);
          }
        });
      } else {
        final email = HiveHelper.instance.getItem("email");
        final password = HiveHelper.instance.getItem("password");

        if (email != null && password != null) {
          // print("password😭😭😭😭 :$password");
          // ProfileCubit.instance
          //     .loginAgain(email: email, password: password)
          //     .then(
          //   (value) async {
          //     await NotificationService.instance.getDeviceToken();
          //     if (mounted) {
          //       if (ProfileCubit.instance.state.profile.userType ==
          //           UserType.support) {
          //         context.go(HomeSupportView.route);
          //       } else {
          //         context.go(BottomNavBarView.route);
          //       }
          //     }
          //   },
          // );
        } else {
          if (mounted) {
            // if (ProfileCubit.instance.state.profile.userType ==
            //     UserType.support) {
            GoRouter.of(context).pushReplacement(MainHomeView.routeName,
                extra: MainHomeViewArgs());
            // } else {
            //   context.go(BottomNavBarView.route);
            // }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorsBox.brightBlue,
      body: Image(
        image: AssetImage(AppImageAssets.splashScreen),
        fit: BoxFit.cover,
      ),
    );
  }
}
