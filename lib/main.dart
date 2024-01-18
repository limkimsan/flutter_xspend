import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';
import 'src/constants/colors.dart';
import 'src/routes/app_route.dart';
import 'src/models/category.dart';

import 'src/bloc/exchange_rate/exchange_rate_bloc.dart';

void main() async {
  String env = 'development';
  await dotenv.load(fileName: '.env.$env');
  Category.seedData();
  final appRoute = AppRoute();
  final initialRoute = await appRoute.getInitialRoute();

  ExchangeRateBloc exchangeRateBloc = ExchangeRateBloc();

  runApp(
    BlocProvider.value(
      value: exchangeRateBloc,
      child: MyApp(initialRoute: initialRoute, appRoute: appRoute)
    )
    // MyApp(initialRoute: initialRoute, appRoute: appRoute)
  );
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