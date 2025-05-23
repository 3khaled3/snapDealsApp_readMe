import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/admin_feature/view/navigation/admin_router.dart';
import 'package:snap_deals/app/auth_feature/view/navigation/auth_router.dart';
import 'package:snap_deals/app/auth_feature/view/pages/splash_screen.dart';
import 'package:snap_deals/app/category/view/category_detials.dart';
import 'package:snap_deals/app/chat_feature/view/navigation/chat_router.dart';
import 'package:snap_deals/app/home_feature/view/navigation/home_router.dart';
import 'package:snap_deals/app/notification/view/notification_view.dart';
import 'package:snap_deals/app/product_feature/view/navigation/product_router.dart';
import 'package:snap_deals/app/request_feature/view/navigation/request_router.dart';

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
        ...RequestRouter.routes,
        GoRoute(
          path: NotificationsView.route,
          builder: (context, state) => const NotificationsView(),
        ),
        GoRoute(
          path: CategoryDetails.route,
          builder: (context, state) =>  CategoryDetails(
            args: state.extra as CategoryDetailsArgs,
          ),
        ),
      ],
    );
    return _goRouter as GoRouter;
  }
}
