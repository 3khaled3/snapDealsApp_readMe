import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_room.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_model.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_status.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_type.dart';
import 'package:snap_deals/core/constants/constants.dart';
import 'package:snap_deals/core/localization/generated/l10n.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/app_router.dart';
import 'package:snap_deals/core/utils/hive_helper.dart';
import 'package:snap_deals/core/utils/lang_cubit/lang_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Initialize binding first and only once
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  // Handle zone errors properly
  runZonedGuarded(() async {
    // Initialize Firebase first
    await _initializeFirebase();

    // Then initialize other services in parallel
    await Future.wait([
      _initializeHive(),
      _initializeSupabase(),
    ]);

    // Run app in the same zone
    _runApp();
  }, (error, stack) => debugPrint('Initialization error: $error'));
}

void _runApp() {
  runApp(
    BlocProvider(
      create: (context) => LangCubit(),
      child: DevicePreview(
        enabled: false,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

Future<void> _initializeFirebase() async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      debugPrint('Firebase initialized successfully');
    } else {
      debugPrint('Firebase already initialized - using existing instance');
    }
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
    if (e.toString().contains('duplicate-app')) {
      final app = Firebase.app();
      debugPrint('Using existing Firebase app: ${app.name}');
    }
  }
}

Future<void> _initializeHive() async {
  await HiveHelper.instance.init('myBox');

  Hive.registerAdapter(ChatRoomAdapter());
  Hive.registerAdapter(MessageModelAdapter());
  Hive.registerAdapter(MessageTypeAdapter());
  Hive.registerAdapter(MessageStatusAdapter());

  await Future.wait([
    Hive.openBox<MessageModel>(Constants.freeChatMessages),
    Hive.openBox<ChatRoom>(Constants.freeChatRooms),
    Hive.openBox<MessageModel>(Constants.supportChatMessages),
    Hive.openBox<ChatRoom>(Constants.supportChatRooms),
  ]);
}

Future<void> _initializeSupabase() async {
  await Supabase.initialize(
    url: 'https://frsafocyzvvgdzgwjzil.supabase.co',
    anonKey: 'your-key-here',
  );
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
            scaffoldBackgroundColor: const Color(0xFFF9FAFB),
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
