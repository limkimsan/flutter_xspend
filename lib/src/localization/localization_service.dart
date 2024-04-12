import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:flutter_xspend/src/localization/main_localization.dart';
import 'package:flutter_xspend/src/constants/languages.dart';

// ignore: constant_identifier_names
const String LANGUAGE_CODE = 'languageCode';

class LocalizationService {
  static String currentLanguage = 'en';

  static Future<Locale> setLocale(languageCode) async {
    currentLanguage = languageCode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(LANGUAGE_CODE, languageCode);
    return localizations[languageCode]!;
  }

  static Future<Locale> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString(LANGUAGE_CODE) ?? 'en';
    currentLanguage = languageCode;
    return localizations[languageCode]!;
  }

  // static translate(BuildContext context, key) {
  //   return MainLocalization.of(context).getTranslatedValue(key);
  // }

  static getTranslatedMonth(date) {
    final DateFormat monthFormat = DateFormat.MMMM(currentLanguage);
    return monthFormat.format(date);
  }

  static getTranslatedMonthYear(date) {
    final DateFormat dateFormat = DateFormat('MMM yy', currentLanguage);
    return dateFormat.format(date);
  }

  static getTranslatedDate(date) {
    final DateFormat dateFormat = DateFormat('d MMM y', currentLanguage);
    return dateFormat.format(date);
  }
}