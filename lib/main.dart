import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'src/app.dart';
import 'src/constants/colors.dart';
import 'src/routes/app_route.dart';

void main() async {
  String env = 'development';
  await dotenv.load(fileName: '.env.$env');
  final initialRoute = await AppRoute.getInitialRoute();
  final appRoute = AppRoute();

  runApp(MyApp(initialRoute: initialRoute, appRoute: appRoute));
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