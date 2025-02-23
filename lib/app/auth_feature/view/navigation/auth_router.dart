//handle go router
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/auth_feature/view/pages/forgot_password_view.dart';
import 'package:snap_deals/app/auth_feature/view/pages/login_view.dart';
import 'package:snap_deals/app/auth_feature/view/pages/on_board.dart';
import 'package:snap_deals/app/auth_feature/view/pages/on_board2.dart';
import 'package:snap_deals/app/auth_feature/view/pages/on_board3.dart';
import 'package:snap_deals/app/auth_feature/view/pages/otp_view.dart';
import 'package:snap_deals/app/auth_feature/view/pages/register_view.dart';
import 'package:snap_deals/app/auth_feature/view/pages/splash_screen.dart';
import 'package:snap_deals/app/home_feature/view_model/product_cubit/product_cubit.dart';

import '../pages/reset_password_view.dart';

abstract class AuthRouter {
  static final List<GoRoute> routes = [
    GoRoute(
      path: SplashScreen.routeName,
      builder: (context, state) {
        SplashScreenArgs? args;
        if (state.extra != null) {
          args = state.extra as SplashScreenArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: SplashScreen(args),
        );
      },
    ),
    GoRoute(
      path: OnBoardScreen.routeName,
      builder: (context, state) {
        OnBoardScreenArgs? args;
        if (state.extra != null) {
          args = state.extra as OnBoardScreenArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: OnBoardScreen(args),
        );
      },
    ),
    GoRoute(
      path: OnBoard2Screen.routeName,
      builder: (context, state) {
        OnBoard2ScreenArgs? args;
        if (state.extra != null) {
          args = state.extra as OnBoard2ScreenArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: OnBoard2Screen(args),
        );
      },
    ),
    GoRoute(
      path: OnBoard3Screen.routeName,
      builder: (context, state) {
        OnBoard3ScreenArgs? args;
        if (state.extra != null) {
          args = state.extra as OnBoard3ScreenArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: OnBoard3Screen(args),
        );
      },
    ),
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) {
        LoginViewArgs? args;
        if (state.extra != null) {
          args = state.extra as LoginViewArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: LoginScreen(args),
        );
      },
    ),
    GoRoute(
      path: ForgetPasswordView.routeName,
      builder: (context, state) {
        ForgetPasswordViewArgs? args;

        args = state.extra as ForgetPasswordViewArgs;

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: ForgetPasswordView(args),
        );
      },
    ),
    GoRoute(
      path: RegisterView.routeName,
      builder: (context, state) {
        RegisterViewArgs? args;
        if (state.extra != null) {
          args = state.extra as RegisterViewArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: RegisterView(args!),
        );
      },
    ),
    GoRoute(
      path: ResetPasswordView.routeName,
      builder: (context, state) {
        ResetPasswordViewArgs? args;
        if (state.extra != null) {
          args = state.extra as ResetPasswordViewArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: ResetPasswordView(args!),
        );
      },
    ),
    GoRoute(
      path: OtpView.routeName,
      builder: (context, state) {
        OtpViewArgs? args;
        if (state.extra != null) {
          args = state.extra as OtpViewArgs;
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: OtpView(args!),
        );
      },
    ),
    //add any other routes in same feature
  ];
}
