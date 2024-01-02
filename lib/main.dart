import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app.dart';
import 'src/constants/colors.dart';
import 'src/login/login_view.dart';

void main() async {
  String env = 'development';
  await dotenv.load(fileName: '.env.$env');

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final initialRoute = prefs.getString('TOKEN') == null ? LoginView.routeName : '/';

  runApp(MyApp(initialRoute: initialRoute));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.custom
    ..indicatorSize = 40.0
    ..radius = 10.0
    ..progressColor = primary
    ..backgroundColor = background
    ..indicatorColor = primary
    ..textColor = primary
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}