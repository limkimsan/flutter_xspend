import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/helpers/transaction_helper.dart';
import 'package:flutter_xspend/src/shared/line_chart/line_chart_left_title.dart';
import 'package:flutter_xspend/src/shared/line_chart/line_chart_bottom_title.dart';
import 'package:flutter_xspend/src/localization/localization_service.dart';

class TransactionLineChart extends StatefulWidget {
  const TransactionLineChart({super.key, required this.transactions});
  final List transactions;

  @override
  State<TransactionLineChart> createState() => _TransactionLineChartState();
}

class _TransactionLineChartState extends State<TransactionLineChart> {
  Map<String, dynamic> chartData = {};
  List<Color> incomeGradientColors = [
    primary,
    primary
  ];
  List<Color> expenseGradientColors = [
    orange,
    red
  ];

  @override
  void initState() {
    super.initState();
    loadInitState();
  }

  @override
  void didUpdateWidget(covariant TransactionLineChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    loadInitState();
  }

  void loadInitState() async {
    final data = await TransactionHelper.getAllMonthlyChartData();
    setState(() {
      chartData = data;
    });
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
            getTitlesWidget: (value, meta) => LineChartBottomTitle(value: value, meta: meta),
            reservedSize: LocalizationService.currentLanguage == 'km' ? 26 : 22,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            // interval: 100,
            getTitlesWidget: (value, meta) => LineChartLeftTitle(value: value, meta: meta),
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
          spots: chartData['income'] ?? [],
          isCurved: true,
          gradient: LinearGradient(
            colors: incomeGradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: incomeGradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
        LineChartBarData(
          spots: chartData['expense'] ?? [],
          isCurved: true,
          gradient: LinearGradient(
            colors: expenseGradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: expenseGradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget legend(color, label) {
    return Row(
      children: [
        Container(
          color: color,
          margin: const EdgeInsets.only(right: 4, top: 0),
          child: const SizedBox(
            width: 10,
            height: 10,
          ),
        ),
        Text(label)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              legend(lightGreen, AppLocalizations.of(context)!.income),
              legend(red, AppLocalizations.of(context)!.expense),
            ]
          ),
        ),
        AspectRatio(
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
        ),
      ],
    );
  }
}