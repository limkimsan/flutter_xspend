import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter_xspend/src/utils/chart_util.dart';
import 'package:flutter_xspend/src/localization/localization_service.dart';

class LineChartBottomTitle extends StatelessWidget {
  const LineChartBottomTitle({super.key, required this.value, required this.meta});

  final double value;
  final TitleMeta meta;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(ChartUtil.getMonthLabels(value.toInt()), style: style),
    );
  }
}