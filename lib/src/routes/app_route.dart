import 'package:flutter/material.dart';
import 'package:flutter_xspend/src/home/home_view.dart';

import 'package:flutter_xspend/src/login/login_view.dart';
import 'package:flutter_xspend/src/sign_up/sign_up_view.dart';
import 'package:flutter_xspend/src/isar/isar_service.dart';

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
}