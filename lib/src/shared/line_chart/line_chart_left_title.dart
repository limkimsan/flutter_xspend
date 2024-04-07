import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter_xspend/src/utils/chart_util.dart';


class LineChartLeftTitle extends StatelessWidget {
  const LineChartLeftTitle({super.key, required this.value, required this.meta});

  final double value;
  final TitleMeta meta;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 11,
    );
    return Text(ChartUtil.getLeftTitle(value), style: style, textAlign: TextAlign.left);
  }
}