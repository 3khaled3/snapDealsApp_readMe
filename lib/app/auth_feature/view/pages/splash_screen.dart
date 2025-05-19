import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/home_feature/view/pages/main_home.dart';
import 'package:snap_deals/app/notification/data/notification_services.dart';
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
          ProfileCubit.instance
              .loginUser(email: email, password: password)
              .then((value) async {
            await NotificationService.instance.getDeviceToken();
            if (mounted) {
              GoRouter.of(context).pushReplacement(MainHomeView.routeName,
                  extra: MainHomeViewArgs());
            }
          });
        } else {
          if (mounted) {
            GoRouter.of(context).pushReplacement(MainHomeView.routeName,
                extra: MainHomeViewArgs());
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
