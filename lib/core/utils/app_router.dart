import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/admin_feature/view/navigation/admin_router.dart';
import 'package:snap_deals/app/auth_feature/view/navigation/auth_router.dart';
import 'package:snap_deals/app/auth_feature/view/pages/splash_screen.dart';
import 'package:snap_deals/app/chat_feature/view/navigation/chat_router.dart';
import 'package:snap_deals/app/home_feature/view/navigation/home_router.dart';
import 'package:snap_deals/app/notification/view/notification_view.dart';
import 'package:snap_deals/app/product_feature/view/navigation/product_router.dart';

abstract class AppRouter {
  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static GoRouter? _goRouter;
  static GoRouter router() {
    _goRouter ??= GoRouter(
      // todo change  '/' with stating screen route name
      initialLocation: SplashScreen.routeName,
      navigatorKey: navKey,
      routes: [
        ...HomeRouter.routes,
        ...AuthRouter.routes,
        ...ProductRouter.routes,
        ...ChatRouter.routes,
        ...AdminRouter.routes,
        GoRoute(
          path: NotificationsView.route,
          builder: (context, state) => const NotificationsView(),
        ),
      ],
    );
    return _goRouter as GoRouter;
  }
}
