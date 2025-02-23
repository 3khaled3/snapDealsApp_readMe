part of 'lang_cubit.dart';

@immutable
sealed class LangState {
  final Locale locale;

  const LangState({required this.locale});
}

final class LangInitial extends LangState {
  const LangInitial({required super.locale});
}

final class LangChanged extends LangState {
  const LangChanged({required super.locale});
}

final class LangError extends LangState {
  const LangError({required super.locale});
}

Locale _initializeLocale() {
  // Retrieve the stored language from Hive
  String? currentLang = HiveHelper.instance.getItem("currentLang");

  // If no language is set, default to 'ar' and save it to Hive
  if (currentLang == null) {
    Locale systemLocale = window.locale;
    currentLang = systemLocale.languageCode;
    if (currentLang != Langs.ar.lang || currentLang != Langs.en.lang) {
      currentLang = Langs.en.lang;
    }

    HiveHelper.instance.addItem("currentLang", currentLang);
  }

  // Match the stored language with the supported locales
  return Tr.delegate.supportedLocales.firstWhere(
    (supportedLocale) => supportedLocale.languageCode == currentLang,
    // Default to English if not found
    orElse: () => const Locale('en'),
  );
}
