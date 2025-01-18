import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:snap_deals/core/utils/app_router.dart';
import 'package:snap_deals/core/utils/hive_helper.dart';
import 'core/localization/generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveHelper.instance.init('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Snap Deals',
      localizationsDelegates: const [
        Tr.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        // Retrieve the stored language from Hive
        String? currentLang = HiveHelper.instance.getItem("currentLang");

        // If no language is set, default to 'en' and save it to Hive
        if (currentLang == null) {
          currentLang = 'en';
          HiveHelper.instance.addItem("currentLang", currentLang);
        }

        // Match the stored language with the supported locales
        return supportedLocales.firstWhere(
          (supportedLocale) => supportedLocale.languageCode == currentLang,
          // Default to English if not found
          orElse: () => const Locale('en'),
        );
      },
      supportedLocales: Tr.delegate.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: AppRouter.router(),
    );
  }
}
