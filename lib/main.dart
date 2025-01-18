import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/app_router.dart';
import 'package:snap_deals/core/utils/hive_helper.dart';
import 'package:snap_deals/core/utils/lang_cubit/lang_cubit.dart';
import 'package:snap_deals/core/utils/responsive_manager.dart';
import 'core/localization/generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveHelper.instance.init('myBox');

  runApp(BlocProvider(
    create: (context) => LangCubit(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LangCubit, LangState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: 'Snap Deals',
          localizationsDelegates: const [
            Tr.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: state.locale,
          supportedLocales: Tr.delegate.supportedLocales,
          theme: ThemeData(
            fontFamily: state.locale == const Locale('ar')
                ? AppTextStyles.fontFamilyNotoKufiArabic
                : AppTextStyles.fontFamilyMontserrat,
          ),
          routerConfig: AppRouter.router(),
          builder: (context, child) {
            // Initialize RM with a valid context
            RM.data.init(context);
            return child!;
          },
        );
      },
    );
  }
}
