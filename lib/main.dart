import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:snap_deals/app/chat_feature/data/models/chat_room.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_model.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_status.dart';
import 'package:snap_deals/app/chat_feature/data/models/message_type.dart';
import 'package:snap_deals/core/localization/generated/l10n.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/app_router.dart';
import 'package:snap_deals/core/utils/hive_helper.dart';
import 'package:snap_deals/core/utils/lang_cubit/lang_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveHelper.instance.init('myBox');
WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.instance.init('myBox');

  Hive.registerAdapter(ChatRoomAdapter());
  Hive.registerAdapter(MessageModelAdapter());
  Hive.registerAdapter(MessageTypeAdapter());
  Hive.registerAdapter(MessageStatusAdapter());

  await Hive.openBox<ChatRoom>('chatRooms');
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://frsafocyzvvgdzgwjzil.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZyc2Fmb2N5enZ2Z2R6Z3dqemlsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgzNTgyMDksImV4cCI6MjA1MzkzNDIwOX0.T2Hl3vwYd-RgmxMzVSFnJZwOIlaYYdQ_qiWYGZDG474',
  );
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
