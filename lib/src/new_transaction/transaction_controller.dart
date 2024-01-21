import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'transaction_service.dart';
import 'package:flutter_xspend/src/utils/api_response_util.dart';
import 'package:flutter_xspend/src/utils/currency_util.dart';
import 'package:flutter_xspend/src/utils/datetime_util.dart';
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
    List transactions = [];
    if (duration == 'custom') {
      Map dateRange = jsonDecode(prefs.getString('DATE_RANGE') as String);
      transactions = await Transaction.getAllByDurationType(duration, dateRange['start'], dateRange['end']);
    }
    else {
      transactions = await Transaction.getAllByDurationType(duration);
    }
    successCallback?.call(transactions);
  }

  static getTransactionDetail(id, callback) async {
    final transaction = await Transaction.findById(id);
    callback?.call(transaction);
  }

  static getAllMonthlyChartData() async {
    List<FlSpot> monthlyIncomes = [];
    List<FlSpot> monthlyExpenses = [];

    for (int i = 0; i < DateTime.now().month; i++) {
      DateTime startDate = DateTimeUtil.getStartOfMonth(i + 1);
      DateTime endDate = DateTimeUtil.getEndOfMonth(i + 1);

      final transactions = await Transaction.getAllByDurationType('custom', startDate.toString(), endDate.toString());
      final total = await calculateTotalExpenseIncome(transactions);
      monthlyIncomes.add(FlSpot(i.toDouble(), total['income']));
      monthlyExpenses.add(FlSpot(i.toDouble(), total['expense']));
    }
    return {
      'expense': monthlyExpenses,
      'income': monthlyIncomes,
    };
  }

  static calculateGrandTotal(callback, [trans]) async {
    if (trans != null) {
      final total = await calculateTotalExpenseIncome(trans, true);
      callback?.call({'income': total['income'], 'expense': total['expense']});
      return;
    }

    loadTransactions((transactions) async {
      final total = await calculateTotalExpenseIncome(transactions, true);
      callback?.call({'income': total['income'], 'expense': total['expense']});
    });
  }

  static calculateTotalExpenseIncome(transactions, [isReturnAll = false]) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int khrRate = prefs.getInt('KHR_RATE') != null ? prefs.getInt('KHR_RATE') as int : 4100;
    int usdRate = prefs.getInt('USD_RATE') != null ? prefs.getInt('USD_RATE') as int : 1;
    Map<String, int> exchangeRate = { 'khr': khrRate, 'usd': usdRate };
    double khrIncome = 0;
    double usdIncome  = 0;
    double khrExpense = 0;
    double usdExpense  = 0;

    for (var transaction in transactions) {
      if (transaction.transactionType == transactionTypes['expense']!['value']) {
        khrExpense += CurrencyUtil.getKHR(transaction.amount, transaction.currencyType, exchangeRate);
        usdExpense += CurrencyUtil.getUSD(transaction.amount, transaction.currencyType, exchangeRate);
      }
      else if (transaction.transactionType == transactionTypes['income']!['value']) {
        khrIncome += CurrencyUtil.getKHR(transaction.amount, transaction.currencyType, exchangeRate);
        usdIncome += CurrencyUtil.getUSD(transaction.amount, transaction.currencyType, exchangeRate);
      }
    }
    
    if (isReturnAll) {
      return {
        'income': {'khr': khrIncome, 'usd': usdIncome},
        'expense': {'khr': khrExpense, 'usd': usdExpense}
      };
    }
    return {
      'income': prefs.getString('BASED_CURRENCY') == 'usd' ? usdIncome : khrIncome,
      'expense': prefs.getString('BASED_CURRENCY') == 'usd' ? usdExpense : khrExpense
    };
  }
}