import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/home_feature/view/navigation/home_router.dart';
import 'package:snap_deals/app/home_feature/view/pages/home_view.dart';

abstract class AppRouter {
  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static GoRouter? _goRouter;
  static GoRouter router() {
    _goRouter ??= GoRouter(
      // todo change  '/' with stating screen route name
      initialLocation: HomeView.routeName,
      navigatorKey: navKey,
      routes: [
        ...HomeRouter.routes,
      ],
    );
    return _goRouter as GoRouter;
  }
}
