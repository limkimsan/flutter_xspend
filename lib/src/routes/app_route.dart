import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/login/login_view.dart';
import 'package:flutter_xspend/src/sign_up/sign_up_view.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case LoginView.routeName:
            return const LoginView();
          case SignUpView.routeName:
          default:
            return const SignUpView();
        }
      },
    );
  }
}