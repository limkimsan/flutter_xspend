import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:flutter_xspend/src/localization/main_localization.dart';
import 'package:flutter_xspend/src/constants/languages.dart';

// ignore: constant_identifier_names
const String LANGUAGE_CODE = 'languageCode';

class LocalizationService {
  static Future<Locale> setLocale(languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(LANGUAGE_CODE, languageCode);
    return localizations[languageCode]!;
  }

  static Future<Locale> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString(LANGUAGE_CODE) ?? 'en';
    return localizations[languageCode]!;
  }

  // static translate(BuildContext context, key) {
  //   return MainLocalization.of(context).getTranslatedValue(key);
  // }
}