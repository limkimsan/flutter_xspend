import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'routes/app_route.dart';
import 'constants/colors.dart';

import 'localization/main_localization.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initialRoute, required this.appRoute});
  final String initialRoute;
  final AppRoute appRoute;

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', 'US');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    var kColorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 105, 191, 100),
      primary: const Color.fromARGB(255, 105, 191, 100),
      // brightness: Brightness.dark,
    );

    return MaterialApp(
      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'app',

      // Provide the generated AppLocalizations to the MaterialApp. This
      // allows descendant Widgets to display the correct translations
      // depending on the user's locale.
      localizationsDelegates: const [
        MainLocalization.delegate,
        // AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en', 'US'), // English, no country code
        Locale('km', 'KM'),
      ],
      localeResolutionCallback:(locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return locale;
          }
        }

        return supportedLocales.first;
      },

      // Use AppLocalizations to configure the correct application title
      // depending on the user's locale.
      //
      // The appTitle is defined in .arb files found in the localization
      // directory.
      // onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
      onGenerateTitle: (BuildContext context) => MainLocalization.of(context).getTranslatedValue('appTitle'),
      color: Colors.white,    // set the background color of the app icon in app switcher (Android)
      // Define a light and dark color theme. Then, read the user's
      // preferred ThemeMode (light, dark, or system default) from the
      // SettingsController to display the correct theme.
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        scaffoldBackgroundColor: const Color.fromARGB(255, 20, 0, 5),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primary,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            minimumSize: const Size.fromHeight(48),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          )
        ),
        textTheme: ThemeData().textTheme.copyWith(
          headlineLarge: const TextStyle(
            fontSize: 36,
            color: Color.fromARGB(255, 105, 191, 100),
            fontWeight: FontWeight.bold
          ),
          headlineMedium: const TextStyle(
            fontSize: 24,
            color: yellow,
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: ThemeData().textTheme.bodyMedium?.copyWith(
            color: Colors.white
          ),
          titleMedium: ThemeData().textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme().copyWith(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          floatingLabelStyle: const TextStyle(color: Colors.white),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontWeight: FontWeight.bold)
          )
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: lightBlack,
          selectedItemColor: primary,
          unselectedItemColor: grey,
        ),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: background,
          iconTheme: const IconThemeData().copyWith(
            color: Colors.white
          ),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          )
        )
      ),
      // darkTheme: ThemeData.dark(),
      onGenerateRoute: (RouteSettings routeSettings) {
        return widget.appRoute.onGenerateRoute(routeSettings);
      },
      initialRoute: widget.initialRoute,
      builder: EasyLoading.init()
    );
  }
}
