import 'package:flutter_xspend/src/models/budget.dart';

class BudgetHelper {
  static loadBudgets(callback) async {
    final List<Budget> budgets = await Budget.getAllOfCurrentUser();
    callback?.call(budgets);
  }
}