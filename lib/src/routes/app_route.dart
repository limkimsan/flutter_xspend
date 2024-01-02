import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_xspend/src/home/home_view.dart';
import 'package:flutter_xspend/src/login/login_view.dart';
import 'package:flutter_xspend/src/sign_up/sign_up_view.dart';
import 'package:flutter_xspend/src/isar/isar_service.dart';
import 'package:flutter_xspend/src/models/user.dart';

class AppRoute {
  final isarService = IsarService();

  static Route onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case LoginView.routeName:
            return const LoginView();
          case SignUpView.routeName:
            return const SignUpView();
          case HomeView.routeName:
          default:
            return const HomeView();
        }
      },
    );
  }

  static getInitialRoute() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('TOKEN') == null && await User.currentLoggedIn() == null) {
      return LoginView.routeName;
    }
    return '/';
  }
}