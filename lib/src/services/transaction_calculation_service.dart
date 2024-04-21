import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:flutter_xspend/src/utils/currency_util.dart';

class TransactionCalculationService {
  static double getTotalExpense(transactions, currencyType, exchangeRates) {
    double total = 0;
    for (Transaction transaction in transactions) {
      if (transaction.transactionType == 1) {
        total += currencyType == 'khr' ? CurrencyUtil.getKHR(transaction.amount, transaction.currencyType, exchangeRates) : CurrencyUtil.getUSD(transaction.amount, transaction.currencyType, exchangeRates);
      }
    }
    return total;
  }
}