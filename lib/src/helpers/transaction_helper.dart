import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_xspend/src/utils/currency_util.dart';
import 'package:flutter_xspend/src/constants/transaction_constant.dart';
import 'package:flutter_xspend/src/models/transaction.dart';

class TransactionHelper {
  List<Transaction> transactions;
  // TransactionHelper(this.transactions);     // constructor using position parameter
  TransactionHelper({this.transactions = const []});    // constructor using named parameter
  // TransactionHelper({List<Transaction>? transactions }) : this.transactions = transactions ?? [];   // the same to the constructor using named parameter above


  // transType: the type of the transaction (0 = expense, 1 = income)
  // displayCurrencyType: the type of the currency to display ('usd' or 'khr')
  // amount: the amount of the transaction
  // transCurrencyType: the currency type that is used in the transaction ('usd' or 'khr')
  // exchangeRates: {khr: 4100, usd: 1}
  static getFormattedAmount(transType, displayCurrencyType, amount, transCurrencyType, exchangeRates) {
    final khrAmount = CurrencyUtil.getKHR(amount, transCurrencyType, exchangeRates);
    final usdAmount = CurrencyUtil.getUSD(amount, transCurrencyType, exchangeRates);
    final formattedKhr = CurrencyUtil.getCurrencyFormat(khrAmount, 'khr');
    final formattedUsd = CurrencyUtil.getCurrencyFormat(usdAmount, 'usd');

    final currencies = {
      'khr': formattedKhr,
      'usd': formattedUsd
    };
    return transType == transactionTypes['expense']!['value'] ? '-${currencies[displayCurrencyType]}' : currencies[displayCurrencyType];
  }

  static getFormattedTotal(List transactions, Map<String, int> exchangeRate, String baseCurrency) {
    double khrIncome = 0;
    double usdIncome = 0;
    double khrExpense = 0;
    double usdExpense = 0;

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

    if (baseCurrency == 'khr') {
      return getCalculatedAmountForDisplay(baseCurrency, khrIncome, khrExpense);
    }
    return getCalculatedAmountForDisplay(baseCurrency, usdIncome, usdExpense);
  }

  static getCalculatedAmountForDisplay(currencyType, income, expense) {
    var result = income - expense;
    final formattedKhr = CurrencyUtil.getCurrencyFormat(result, 'khr');
    final formattedUsd = CurrencyUtil.getCurrencyFormat(result, 'usd');
    return currencyType == "khr" ? formattedKhr : formattedUsd;
  }

  static getGroupedTransactions(transactions, exchangeRate, baseCurrency) {
    final groupedList = groupBy(transactions, (t) => (t as Transaction).transactionDate?.toIso8601String().split('T')[0]);   // group the transaction by the the date only (exclude the time)
    final formattedList = [];
    groupedList.forEach((key, value) {
      final obj = {
        'title': {'date': key.toString(), 'total': getFormattedTotal(value, exchangeRate, baseCurrency)},
        'data': value,
      };
      formattedList.add(obj);
    });
    return formattedList;
  }

  static loadTransactions(successCallback, [failureCallback]) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String duration = prefs.getString('TRANSACTION_DURATION') ?? 'month';
    List transactions = [];
    if (duration == 'custom') {
      Map dateRange = jsonDecode(prefs.getString('DATE_RANGE') as String);
      transactions = await Transaction.getAllByDurationType(
          duration, dateRange['start'], dateRange['end']);
    } else {
      transactions = await Transaction.getAllByDurationType(duration);
    }
    successCallback?.call(transactions);
  }

  calculateTotalExpenseIncome([isReturnAll = false]) async {
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

  void calculateTransactionsGrandTotal(callback) async {
    if (transactions.isNotEmpty) {
      final total = await calculateTotalExpenseIncome(true);
      callback?.call({'income': total['income'], 'expense': total['expense']});
      return;
    }

    loadTransactions((trans) async {
      transactions = trans;
      final total = await calculateTotalExpenseIncome(true);
      callback?.call({'income': total['income'], 'expense': total['expense']});
    });
  }
}