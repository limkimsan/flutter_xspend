import 'package:fl_chart/fl_chart.dart';

import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:flutter_xspend/src/utils/datetime_util.dart';
import 'package:flutter_xspend/src/new_transaction/transaction_controller.dart';

class WalletController {
  static getMonthlyBalancesChartData() async {
    List<FlSpot> monthlyBalances = [];

    for (int i = 0; i < 12; i++) {
      DateTime startDate = DateTimeUtil.getStartOfMonth(i + 1);
      DateTime endDate = DateTimeUtil.getEndOfMonth(i + 1);
      final transactions = await Transaction.getAllByDurationType(
          'custom', startDate.toString(), endDate.toString());
      final total = await TransactionController.calculateTotalExpenseIncome(transactions);
      monthlyBalances.add(FlSpot(i.toDouble(), total['income'] - total['expense']));
    }
    return monthlyBalances;
  }
}