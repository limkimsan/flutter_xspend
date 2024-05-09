import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_xspend/src/utils/currency_util.dart';
import 'package:flutter_xspend/src/helpers/transaction_helper.dart';
import 'package:flutter_xspend/src/localization/localization_service.dart';
import 'package:flutter_xspend/src/models/transaction.dart';

String getKFormat(number) {
  final formatter = NumberFormat.compact(locale: LocalizationService.currentLanguage == 'km' ? 'km' : 'en_US', explicitSign: false);
  return formatter.format(number);
}

class HomeWidgetService {
  static updateInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Transaction> transactions = await Transaction.getAllByMonth(DateTime.now());
    String currencyType = prefs.getString('BASED_CURRENCY') ?? 'km';

    TransactionHelper(transactions: transactions).calculateTransactionsGrandTotal((result) {
      double income = result['income'][currencyType];
      double expense = result['expense'][currencyType];

      HomeWidget.saveWidgetData<String>('income', CurrencyUtil.getCurrencyFormat(income, currencyType));
      HomeWidget.saveWidgetData<String>('kFormatIncome', getKFormat(income));
      HomeWidget.saveWidgetData<String>('expense', CurrencyUtil.getCurrencyFormat(expense, currencyType));
      HomeWidget.saveWidgetData<String>('kFormatExpense', getKFormat(expense));
      HomeWidget.saveWidgetData<String>('total', TransactionHelper.getCalculatedAmountForDisplay(currencyType, income, expense));
      HomeWidget.saveWidgetData<String>('currency', currencyType);
      HomeWidget.updateWidget(
        iOSName: 'SummaryWidget'
      );
    });
  }
}