import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/utils/chart_util.dart';

class TransactionLineChart extends StatefulWidget {
  const TransactionLineChart({super.key});

  @override
  State<TransactionLineChart> createState() => _TransactionLineChartState();
}

class _TransactionLineChartState extends State<TransactionLineChart> {

  List<Color> gradientColors = [
    primary,
    primary
  ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 11,
    );
    return Text(ChartUtil.getLeftTitle(value), style: style, textAlign: TextAlign.left);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
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

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        // horizontalInterval: 1,
        // verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: primary,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: secondary,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            // interval: 100,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      // minX: 0,
      // maxX: 11,
      // minY: 0,
      // maxY: 7,
      lineBarsData: [
        LineChartBarData(
          spots: ChartUtil.getChartData(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
          aspectRatio: 1.8,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 12,
              left: 4,
              bottom: 16,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        );
  }
}