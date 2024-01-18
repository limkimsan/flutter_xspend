import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_xspend/src/utils/currency_util.dart';
import 'package:flutter_xspend/src/constants/transaction_constant.dart';
import 'package:flutter_xspend/src/models/transaction.dart';

class TransactionHelper {
  // transType: the type of the transaction (0 = expense, 1 = income)
  // displayCurrencyType: the type of the currency to display ('usd' or 'khr')
  // amount: the amount of the transaction
  // transCurrencyType: the currency type that is used in the transaction ('usd' or 'khr')
  // exchangeRates: {khr: 4100, usd: 1}
  static getFormattedAmount(transType, displayCurrencyType, amount, transCurrencyType, exchangeRates) {
    final khrAmount = CurrencyUtil.getKHR(amount, transCurrencyType, exchangeRates);
    final usdAmount = CurrencyUtil.getUSD(amount, transCurrencyType, exchangeRates);

    final formattedKhr = NumberFormat.currency(
      symbol: 'KHR ',
    ).format(khrAmount);

    final formattedUsd = NumberFormat.currency(
      symbol: '\$',
    ).format(usdAmount);

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
    final formattedKhr = NumberFormat.currency(
      symbol: 'KHR ',
    ).format(result);
    final formattedUsd = NumberFormat.currency(
      symbol: '\$',
    ).format(result);

    return currencyType == "khr" ? formattedKhr : formattedUsd;
  }

  static getGroupedTransactions(transactions, exchangeRate, baseCurrency) {
    final groupedList = groupBy(transactions, (t) => (t as Transaction).transactionDate);
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
}