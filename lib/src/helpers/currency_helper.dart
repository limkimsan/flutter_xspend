import 'package:intl/intl.dart';

import 'package:flutter_xspend/src/utils/currency_util.dart';
import 'package:flutter_xspend/src/constants/transaction_constant.dart';

class CurrencyHelper {
  // transType: the type of the transaction (0 = expense, 1 = income)
  // displayCurrencyType: the type of the currency to display ('usd' or 'khr')
  // amount: the amount of the transaction
  // transCurrencyType: the currency type that is used in the transaction ('usd' or 'khr')
  // exchangeRates: {khr: 4100, usd: 1}
  static getTransactionCurrency(transType, displayCurrencyType, amount, transCurrencyType, exchangeRates) {
    final khrAmount = CurrencyUtil.getKHR(amount, transCurrencyType, exchangeRates);
    final usdAmount = CurrencyUtil.getUSD(amount, transCurrencyType, exchangeRates);

    final formattedKhr = NumberFormat.currency(
      symbol: 'KHR',
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
}