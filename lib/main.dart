import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'src/app.dart';

void main() async {
  String env = 'development';
  await dotenv.load(fileName: '.env.$env');

  runApp(const MyApp());
}
