import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartUtil {
  static getMonthLabels(index) {
    List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    if (index >= 12) {
      return '';
    }

    return months[index];
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