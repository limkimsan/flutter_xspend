import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/shared/line_chart/line_chart_left_title.dart';
import 'package:flutter_xspend/src/shared/line_chart/line_chart_bottom_title.dart';
import 'package:flutter_xspend/src/wallets/wallet_controller.dart';
import 'package:flutter_xspend/src/localization/localization_service.dart';

class WalletLineChart extends StatefulWidget {
  const WalletLineChart({super.key});

  @override
  State<WalletLineChart> createState() => _WalletLineChartState();
}

class _WalletLineChartState extends State<WalletLineChart> {
  List<FlSpot> chartData = [];

  @override
  void initState() {
    super.initState();
    loadBalances();
  }

  void loadBalances() async {
    final data = await WalletController.getMonthlyBalancesChartData();
    setState(() {
      chartData = data;
    });
  }

  Widget legend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: lightGreen,
          margin: const EdgeInsets.only(right: 4, top: 0),
          child: const SizedBox(width: 12, height: 12)
        ),
        Text(AppLocalizations.of(context)!.balance)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Color> incomeGradientColors = [primary, primary];

    LineChartData mainData() {
      return LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
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
            sideTitles: SideTitles(showTitles: false)
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
            )
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => LineChartLeftTitle(value: value, meta: meta),
              reservedSize: 42
            )
          )
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d))
        ),
        lineBarsData: [
          LineChartBarData(
            spots: chartData,
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
                colors: incomeGradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            ),
          ),
        ]
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: legend(),
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
              mainData()
            )
          ),
        ),
      ],
    );
  }
}