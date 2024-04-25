import 'package:flutter_xspend/src/models/budget.dart';
import 'package:flutter_xspend/src/services/transaction_calculation_service.dart';

class BudgetCalculationService {
  final Budget budget;
  final Map<String, dynamic> exchangeRates;
  final List transactions;

  BudgetCalculationService(this.budget, this.transactions, this.exchangeRates);

  getProgress() {
    final double totalExpense = TransactionCalculationService.getTotalExpense(transactions, budget.currencyType, exchangeRates);
    double percentage = totalExpense / budget.amount!;

    return {
      'expense': totalExpense,
      'percentage': percentage,
      'remainAmount': budget.amount! - totalExpense,
      'amountEachDay': (budget.amount! - totalExpense) / _getNumberOfDays(),
      'remainingDays': _getNumberOfDays(),
    };
  }

  // private method
  int _getNumberOfDays() {
    Duration difference = budget.endDate!.difference(budget.startDate!);
    return difference.inDays;
  }
}