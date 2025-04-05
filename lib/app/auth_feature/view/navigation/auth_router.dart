//handle go router
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/forgot_password_view.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/login_view.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/otp_view.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/privacy_Policy.dart';
import 'package:snap_deals/app/auth_feature/view/pages/auth_view/register_view.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/settings.dart';
import 'package:snap_deals/app/auth_feature/view/pages/splash_screen.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/your_profile.dart';
import 'package:snap_deals/app/home_feature/view_model/product_cubit/product_cubit.dart';
import 'package:snap_deals/app/on_board_feature/view/on_boarding_view.dart';

import '../pages/auth_view/reset_password_view.dart';

abstract class AuthRouter {
  static final List<GoRoute> routes = [
    GoRoute(
      path: SplashScreen.routeName,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: OnBoardScreen.routeName,
      builder: (context, state) {
        return const OnBoardScreen();
      },
    ),

    GoRoute(
      path: YourProfileView.routeName,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: const YourProfileView(),
        );
      },
    ),
    GoRoute(
      path: SettingsView.routeName,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: const SettingsView(),
        );
      },
    ),
    GoRoute(
      path: PrivacyPolicyView.routeName,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: const PrivacyPolicyView(),
        );
      },
    ),

    GoRoute(
      path: AboutUsView.routeName,
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCubit()),
          ],
          child: const AboutUsView(),
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
