import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter_xspend/src/localization/localization_service.dart';

class ChartUtil {
  static getMonthLabels(index) {
    List<Map<String, String>> months = [
      { 'en': 'Jan', 'km': 'មករា' },
      { 'en': 'Feb', 'km': 'កុម្ភៈ' },
      { 'en': 'Mar', 'km': 'មីនា' },
      { 'en': 'Apr', 'km': 'មេសា' },
      { 'en': 'May', 'km': 'ឧសភា' },
      { 'en': 'Jun', 'km': 'មិថុនា' },
      { 'en': 'Jul', 'km': 'កក្កដា' },
      { 'en': 'Aug', 'km': 'សីហា' },
      { 'en': 'Sep', 'km': 'កញ្ញា' },
      { 'en': 'Oct', 'km': 'តុលា' },
      { 'en': 'Nov', 'km': 'វិច្ឆិកា' },
      { 'en': 'Dec', 'km': 'ធ្នូ' },
    ];

    if (index >= 12) {
      return '';
    }
    return months[index][LocalizationService.currentLanguage];
  }

  static getLeftTitle(number) {
    final formatter = NumberFormat.compact(locale: 'en_US', explicitSign: false);
    return formatter.format(number);
  }

  static getChartData() {
    List<FlSpot> data = [
      const FlSpot(0, 3000),
      const FlSpot(1, 3700),
      const FlSpot(2, 4200),
      const FlSpot(3, 4600),
      const FlSpot(4, 5200),
      const FlSpot(5, 5900),
      const FlSpot(6, 6900),
      const FlSpot(7, 10000),
      const FlSpot(8, 20000),
    ];
    return data;
  }
}