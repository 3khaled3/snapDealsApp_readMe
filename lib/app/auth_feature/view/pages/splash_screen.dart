import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/auth_feature/view/pages/on_board.dart';

import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
    GoRouter.of(context).push(OnBoardScreen.routeName);
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
