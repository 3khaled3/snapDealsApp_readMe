import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/home_feature/view/pages/home_view.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class SplashScreenArgs {}

class SplashScreen extends StatefulWidget {
  const SplashScreen(this.args, {super.key});
  final SplashScreenArgs? args;
  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  _goNext() {
    GoRouter.of(context).push(HomeView.routeName, extra: HomeViewArgs());
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
