import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'transaction_service.dart';
import 'package:flutter_xspend/src/utils/api_response_util.dart';
import 'package:flutter_xspend/src/utils/currency_util.dart';
import 'package:flutter_xspend/src/helpers/transaction_helper.dart';
import 'package:flutter_xspend/src/constants/transaction_constant.dart';

class TransactionController {
  static isValid(category, amount, date) {
    return category != null && amount != '' && double.parse(amount) > 0 && date != null;
  }

  static create(Transaction transaction, successCallback, failureCallback) async {
    // save new transaction in local
    Transaction.create(transaction);
    loadTransactions((transactions) {
      successCallback?.call(transactions);
    });

    // if (await InternetConnectionChecker().hasConnection) {
    //   try {
    //     final response = await TransactionService.sendCreateRequest(transaction);
    //     ApiResponseUtil.handleResponse(response, () {
    //       transaction.synced = true;
    //       Transaction.create(transaction);
    //       successCallback?.call();
    //     }, (errorMsg) {
    //       failureCallback?.call('Failed to create new transaction.');
    //     });
    //   }
    //   catch (error) {
    //     print('= create transaction error = $error');
    //     Transaction.create(transaction);
    //     failureCallback?.call('Failed to create new transaction.');
    //   }
    // }
    // else {
    //   Transaction.create(transaction);
    //   successCallback?.call();
    // }
  }

  static update(Transaction transaction, successCallback) {
    Transaction.update(transaction.id, {
      'amount': transaction.amount,
      'currencyType': transaction.currencyType,
      'note': transaction.note,
      'transactionType': transaction.transactionType,
      'transactionDate': transaction.transactionDate,
      'category': transaction.category,
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      loadTransactions((transactions) => {successCallback?.call(transactions)});
    });
  }

  static delete(String id, successCallback) {
    Transaction.deleteById(id);
    Future.delayed(const Duration(milliseconds: 100), () {
      loadTransactions((transactions) => {successCallback?.call(transactions)});
    });
  }

  static loadTransactions(successCallback, [failureCallback]) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String duration = prefs.getString('TRANSACTION_DURATION') ?? 'month';
    final transactions = await Transaction.getAllByDurationType(duration);
    successCallback?.call(transactions);
  }

  static getTransactionDetail(id, callback) async {
    final transaction = await Transaction.findById(id);
    callback?.call(transaction);
  }

  static getAllMonthlyChartData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int khrRate = prefs.getInt('KHR_RATE') != null ? prefs.getInt('KHR_RATE') as int : 4100;
    int usdRate = prefs.getInt('USD_RATE') != null ? prefs.getInt('USD_RATE') as int : 1;
    Map<String, int> exchangeRate = { 'khr': khrRate, 'usd': usdRate };

    List<FlSpot> monthlyIncomes = [];
    List<FlSpot> monthlyExpenses = [];


    for (int i = 0; i < DateTime.now().month; i++) {
      double income = 0;
      double expense = 0;
      DateTime now = DateTime.now();
      DateTime startDate = DateTime(now.year, i + 1, 1);
      DateTime startOfNextMonth = DateTime(now.year, i + 2, 1);
      DateTime endDate = startOfNextMonth.subtract(const Duration(days: 1));

      final transactions = await Transaction.getAllByDurationType('custom', startDate.toString(), endDate.toString());
      for (var transaction in transactions) {
        if (transaction.transactionType == transactionTypes['expense']!['value']) {
          expense += prefs.getString('BASED_CURRENCY') == 'usd'
                      ? CurrencyUtil.getUSD(transaction.amount, transaction.currencyType, exchangeRate)
                      : CurrencyUtil.getKHR(transaction.amount, transaction.currencyType, exchangeRate);
        }
        else if (transaction.transactionType == transactionTypes['income']!['value']) {
          income += prefs.getString('BASED_CURRENCY') == 'usd'
                      ? CurrencyUtil.getUSD(transaction.amount, transaction.currencyType, exchangeRate)
                      : CurrencyUtil.getKHR(transaction.amount, transaction.currencyType, exchangeRate);
        }
      }
      monthlyIncomes.add(FlSpot(i.toDouble(), income));
      monthlyExpenses.add(FlSpot(i.toDouble(), expense));
    }
    return {
      'expense': monthlyExpenses,
      'income': monthlyIncomes,
    };
  }
}