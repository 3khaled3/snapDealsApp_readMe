import 'package:flutter/material.dart';

import 'package:snap_deals/core/localization/generated/l10n.dart';
import 'package:snap_deals/core/utils/lang_cubit/lang_cubit.dart';

String translateFont({required String arabicFont, required String otherFont}) {
  // Add logic to check the current locale dynamically.
  return Tr.current.lang == Langs.ar.lang ? arabicFont : otherFont;
}

String defaultFontFamily() {
  return translateFont(arabicFont: 'NotoKufiArabic', otherFont: "Montserrat");
}

class AppTextStyles {
  // Font families
  static const String fontFamilyMontserrat = "Montserrat";
  static const String fontFamilyLora = "Lora";
  static const String fontFamilyNotoKufiArabic = "NotoKufiArabic";

  // Text styles with dynamic sizes using RM.map
  static TextStyle bold42() => TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: defaultFontFamily(),
        fontSize: 42,
      );

  static TextStyle regular34() => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: defaultFontFamily(),
        fontSize: 34,
      );

  static TextStyle semiBold30() => TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: defaultFontFamily(),
        fontSize: 30,
      );

  static TextStyle semiBold24() => TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: defaultFontFamily(),
        fontSize: 24,
      );

  static TextStyle medium22() => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: defaultFontFamily(),
        fontSize: 22,
      );

  static TextStyle semiBold20() => TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: defaultFontFamily(),
        fontSize: 20,
      );

  static TextStyle medium20() => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: defaultFontFamily(),
        fontSize: 20,
      );

  static TextStyle medium18() => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: defaultFontFamily(),
        fontSize: 18,
      );

  static TextStyle regular18() => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: defaultFontFamily(),
        fontSize: 18,
      );

  static TextStyle medium16() => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: defaultFontFamily(),
        fontSize: 16,
      );

  static TextStyle regular16() => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: defaultFontFamily(),
        fontSize: 16,
      );

  static TextStyle bold12() => TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: defaultFontFamily(),
        fontSize: 12,
      );

  static TextStyle medium12() => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: defaultFontFamily(),
        fontSize: 12,
      );

  static TextStyle regular12() => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: defaultFontFamily(),
        fontSize: 12,
      );

  static TextStyle regular10() => TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: defaultFontFamily(),
        fontSize: 10,
      );
}
