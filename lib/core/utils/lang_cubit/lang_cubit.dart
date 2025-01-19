import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:snap_deals/core/localization/generated/l10n.dart';
import 'package:snap_deals/core/utils/hive_helper.dart';

part 'lang_state.dart';

enum Langs {
  ar("ar"),
  en("en");

  final String lang;

  const Langs(this.lang);
}

class LangCubit extends Cubit<LangState> {
  LangCubit() : super(LangInitial(locale: _initializeLocale()));

  void changeLang(Langs lang) {
    if (Tr.current.lang == lang.lang) {
      emit(LangError(locale: _initializeLocale()));
    } else if (lang == Langs.ar || lang == Langs.en) {
      HiveHelper.instance.addItem("currentLang", lang.lang);

      emit(LangChanged(locale: _initializeLocale()));
    }
  }
}
