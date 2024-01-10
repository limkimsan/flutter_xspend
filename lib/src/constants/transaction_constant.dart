import 'package:flutter/material.dart';

import 'colors.dart';

final transactionTypes = {
  'expense': {'label': 'Expense', 'value': 1, 'bgColor': red, 'icon': const Icon(Icons.arrow_circle_up_outlined)},
  'income': {'label': 'Income', 'value': 0, 'bgColor': success, 'icon': const Icon(Icons.arrow_circle_down_outlined)}
};