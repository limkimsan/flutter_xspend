import 'package:uuid/uuid.dart';

import 'package:flutter_xspend/src/models/budget.dart';
import 'package:flutter_xspend/src/models/user.dart';

class NewBudgetController {
  static bool isValidForm(name, amount, startDate, endDate) {
    return name != null && name != '' && amount != null && amount != '' && double.parse(amount) > 0 && startDate != null && endDate != null;
  }

  static createBudget(name, amount, startDate, endDate, currencyType) async {
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
  }
}