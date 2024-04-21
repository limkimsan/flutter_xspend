import 'package:uuid/uuid.dart';

import 'package:flutter_xspend/src/models/budget.dart';
import 'package:flutter_xspend/src/models/user.dart';
import 'package:flutter_xspend/src/helpers/budget_helper.dart';

class BudgetController {
  static bool isValidForm(name, amount, startDate, endDate) {
    return name != null && name != '' && amount != null && amount != '' && double.parse(amount) > 0 && startDate != null && endDate != null;
  }

  static create(name, amount, startDate, endDate, currencyType, callback) async {
    const uuid = Uuid();
    final budget = Budget()
                    ..id = uuid.v4()
                    ..name = name
                    ..amount = double.parse(amount)
                    ..startDate = startDate
                    ..endDate = endDate
                    ..currencyType = currencyType
                    ..user.value = await User.currentLoggedIn();

    Budget.create(budget);
    BudgetHelper.loadBudgets((budgets) {
      callback?.call(budgets);
    });
  }

  static delete(String id, callback) {
    Budget.deleteById(id);
    Future.delayed(const Duration(milliseconds: 100), () {
      BudgetHelper.loadBudgets((budgets) {
        callback?.call(budgets);
      });
    });
  }
}