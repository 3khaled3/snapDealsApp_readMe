import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:snap_deals/core/localization/generated/l10n.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/app_router.dart';
import 'package:snap_deals/core/utils/hive_helper.dart';
import 'package:snap_deals/core/utils/lang_cubit/lang_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveHelper.instance.init('myBox');

  runApp(BlocProvider(
    create: (context) => LangCubit(),
    child: DevicePreview(enabled: false, builder: (context) => const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LangCubit, LangState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
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
            fontFamily: state.locale == const Locale('en')
                ? AppTextStyles.fontFamilyNotoKufiArabic
                : AppTextStyles.fontFamilyMontserrat,
          ),
          routerConfig: AppRouter.router(),
          builder: (context, child) {
            // Initialize RM with a valid context
            return child!;
          },
        );
      },
    );
  }
}
