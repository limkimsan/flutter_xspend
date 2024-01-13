import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_xspend/src/bottom_tab/bottom_tab_view.dart';
import 'package:flutter_xspend/src/home/home_view.dart';
import 'package:flutter_xspend/src/login/login_view.dart';
import 'package:flutter_xspend/src/sign_up/sign_up_view.dart';
import 'package:flutter_xspend/src/new_transaction/new_transaction_view.dart';
import 'package:flutter_xspend/src/isar/isar_service.dart';
import 'package:flutter_xspend/src/models/user.dart';
import 'package:flutter_xspend/src/models/category.dart';

class AppRoute {
  final isarService = IsarService();

  AppRoute() {
    Category.seedData();
  }

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
            return const HomeView();
          case NewTransactionView.routeName:
            return const NewTransactionView();
          case BottomTabView.routeName:
          default:
            return const BottomTabView();
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