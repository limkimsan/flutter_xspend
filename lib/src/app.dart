import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'routes/app_route.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var kColorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 105, 191, 100),
      primary: const Color.fromARGB(255, 105, 191, 100),
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
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],

      // Use AppLocalizations to configure the correct application title
      // depending on the user's locale.
      //
      // The appTitle is defined in .arb files found in the localization
      // directory.
      onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,

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
            textStyle: const TextStyle(fontWeight: FontWeight.bold)
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          headlineLarge: const TextStyle(
            fontSize: 36,
            color: Color.fromARGB(255, 105, 191, 100),
            fontWeight: FontWeight.bold
          )
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
      ),
      darkTheme: ThemeData.dark(),
      onGenerateRoute: (RouteSettings routeSettings) {
        return AppRoute.onGenerateRoute(routeSettings);
      },
    );
  }
}
