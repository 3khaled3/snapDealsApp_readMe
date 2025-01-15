import 'dart:ui';

import 'package:snap_deals/core/utils/responsive_manager.dart';

String translateFont({required String arabicFont, required String otherFont}) {
  // TODO: Add logic to check the current locale dynamically.
  return 'ar' == 'ar' ? arabicFont : otherFont;
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
  static TextStyle bold42 = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily(),
    fontSize: RM.data.mapSize(mobile: 42.0, tablet: 48.0),
  );

  static TextStyle regular34 = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily(),
    fontSize: RM.data.mapSize(mobile: 34.0, tablet: 40.0),
  );

  static TextStyle semiBold30 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: defaultFontFamily(),
    fontSize: RM.data.mapSize(mobile: 30.0, tablet: 36.0),
  );

  static TextStyle semiBold24 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: defaultFontFamily(),
    fontSize: RM.data.mapSize(mobile: 24.0, tablet: 28.0),
  );

  static TextStyle medium22 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: defaultFontFamily(),
    fontSize: RM.data.mapSize(mobile: 22.0, tablet: 26.0),
  );

  static TextStyle semiBold20 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: defaultFontFamily(),
    fontSize: RM.data.mapSize(mobile: 20.0, tablet: 24.0),
  );

  static TextStyle medium20 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: defaultFontFamily(),
    fontSize: RM.data.mapSize(mobile: 20.0, tablet: 24.0),
  );

  static TextStyle medium18 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: defaultFontFamily(),
    fontSize: RM.data.mapSize(mobile: 18.0, tablet: 22.0),
  );

  static TextStyle regular18 = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily(),
    fontSize: RM.data.mapSize(mobile: 18.0, tablet: 22.0),
  );

  static TextStyle medium16 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: defaultFontFamily(),
    fontSize: RM.data.mapSize(mobile: 16.0, tablet: 20.0),
  );

  static TextStyle regular16 = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily(),
    fontSize: RM.data.mapSize(mobile: 16.0, tablet: 20.0),
  );

  static TextStyle bold12 = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: defaultFontFamily(),
    fontSize: RM.data.mapSize(mobile: 12.0, tablet: 14.0),
  );

  static TextStyle medium12 = TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: defaultFontFamily(),
    fontSize: RM.data.mapSize(mobile: 12.0, tablet: 14.0),
  );

  static TextStyle regular12 = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily(),
    fontSize: RM.data.mapSize(mobile: 12.0, tablet: 14.0),
  );

  static TextStyle regular10 = TextStyle(
    fontWeight: FontWeight.w400,
    fontFamily: defaultFontFamily(),
    fontSize: RM.data.mapSize(mobile: 10.0, tablet: 12.0),
  );
}
