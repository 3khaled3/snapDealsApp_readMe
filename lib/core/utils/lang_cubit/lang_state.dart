part of 'lang_cubit.dart';

@immutable
sealed class LangState {
    final Locale locale;

  const LangState({ required this.locale});
}

final class LangInitial extends LangState {
  // static final locale = ;

  LangInitial({required super.locale});
}

final class LangChanged extends LangState {
  // final Locale locale;

  const LangChanged({
    // required this.locale,
   required super.locale});
}
final class LangError extends LangState {
  LangError({required super.locale});
}

Locale _initializeLocale() {
  // Retrieve the stored language from Hive
  String? currentLang = HiveHelper.instance.getItem("currentLang");

  // If no language is set, default to 'en' and save it to Hive
  if (currentLang == null) {
    currentLang = 'en';
    HiveHelper.instance.addItem("currentLang", currentLang);
  }

  // Match the stored language with the supported locales
  return Tr.delegate.supportedLocales.firstWhere(
    (supportedLocale) => supportedLocale.languageCode == currentLang,
    // Default to English if not found
    orElse: () => const Locale('en'),
  );
}
