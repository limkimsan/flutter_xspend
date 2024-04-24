import 'package:uuid/uuid.dart';

import 'package:flutter_xspend/src/models/budget.dart';
import 'package:flutter_xspend/src/models/user.dart';
import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:flutter_xspend/src/constants/colors.dart';

class BudgetController {
  static bool isValidForm(name, amount, startDate, endDate) {
    return name != null && name != '' && amount != null && amount != '' && double.parse(amount) > 0 && startDate != null && endDate != null;
  }

  static loadBudgets(callback) async {
    final List<Budget> budgets = await Budget.getAllOfCurrentUser();
    List tranList = [];

    for (Budget budget in budgets) {
      final transactions = await Transaction.getAllByDurationType('custom', budget.startDate.toString(), budget.endDate.toString());
      tranList.add(transactions);
    }
    callback?.call(budgets, tranList);
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
    Future.delayed(const Duration(milliseconds: 100), () {
      loadBudgets((budgets, tranList) {
        callback?.call(budgets, tranList);
      });
    });
  }

  static update(id, name, amount, startDate, endDate, currencyType, callback) async {
    Map<String, dynamic> params = {
      'name': name,
      'amount': double.parse(amount),
      'startDate': startDate,
      'endDate': endDate,
      'currencyType': currencyType,
    };
    Budget.update(id, params);
    Future.delayed(const Duration(milliseconds: 100), () {
      loadBudgets((budgets, tranList) {
        callback?.call(budgets, tranList);
      });
    });
  }

  static delete(String id, callback) {
    Budget.deleteById(id);
    Future.delayed(const Duration(milliseconds: 100), () {
      loadBudgets((budgets, tranList) {
        callback?.call(budgets, tranList);
      });
    });
  }

  static getProgressBarColor(percentage) {
    if (percentage < 0.5) {
      return lightGreen;
    }
    else if (percentage < 0.75) {
      return yellow;
    }
    return percentage < 0.85 ? orange : red;
  }
}