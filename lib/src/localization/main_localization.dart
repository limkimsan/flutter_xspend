// An alternative class for the app's localized resources (this approach cannout use localization with placeholder, pluralized, etc)

//=========
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class MainLocalization {
//   MainLocalization(this.locale);

//   final Locale locale; 

//   static MainLocalization of(BuildContext context) {
//     return Localizations.of(context, MainLocalization);
//   }

//   Map<String, String> _localizedValues = {};

//   Future load() async {
//     String jsonStringValues = await rootBundle.loadString('lib/src/localization/app_${locale.languageCode}.arb');
//     Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
//     _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));
//   }

//   String getTranslatedValue(key) {
//     return _localizedValues[key].toString();
//   }

//   static const LocalizationsDelegate<MainLocalization> delegate = _MainLocalizationDelegate();
// }

// class _MainLocalizationDelegate extends LocalizationsDelegate<MainLocalization> {
//   const _MainLocalizationDelegate();

//   @override
//   bool isSupported(Locale locale) {
//     return ['en', 'km'].contains(locale.languageCode);
//   }

//   @override
//   Future<MainLocalization> load(Locale locale) async {
//     MainLocalization mainLocalization = MainLocalization(locale);
//     await mainLocalization.load();
//     return mainLocalization;
//   }

//   @override
//   bool shouldReload(_MainLocalizationDelegate old) => false;
// }