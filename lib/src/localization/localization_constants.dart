import 'package:flutter/material.dart';
import 'package:flutter_xspend/src/localization/main_localization.dart';

String getTranslated(BuildContext context, key) {
  return MainLocalization.of(context).getTranslatedValue(key);
}