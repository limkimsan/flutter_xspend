import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_xspend/src/utils/currency_util.dart';
import 'package:flutter_xspend/src/helpers/transaction_helper.dart';
import 'package:flutter_xspend/src/models/transaction.dart';

class HomeWidgetService {
  static updateInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Transaction> transactions = await Transaction.getAllByMonth(DateTime.now());
    String currencyType = prefs.getString('BASED_CURRENCY') ?? 'km';

    TransactionHelper(transactions: transactions).calculateTransactionsGrandTotal((result) {
      double income = result['income'][currencyType];
      double expense = result['expense'][currencyType];

      HomeWidget.saveWidgetData<String>('income', CurrencyUtil.getCurrencyFormat(income, currencyType));
      HomeWidget.saveWidgetData<String>('kFormatIncome', CurrencyUtil.getKFormat(income, currencyType));
      HomeWidget.saveWidgetData<String>('expense', CurrencyUtil.getCurrencyFormat(expense, currencyType));
      HomeWidget.saveWidgetData<String>('kFormatExpense', CurrencyUtil.getKFormat(expense, currencyType));
      HomeWidget.saveWidgetData<String>('total', TransactionHelper.getCalculatedAmountForDisplay(currencyType, income, expense));
      HomeWidget.saveWidgetData<String>('currency', currencyType);
      HomeWidget.updateWidget(
        iOSName: 'SummaryWidget'
      );
    });
  }

  static updateLocale(locale) {
    HomeWidget.saveWidgetData<String>('locale', locale);
  }

  static updateCurrencyType(currencyType) {
    HomeWidget.saveWidgetData<String>('currency', currencyType);
  }
}