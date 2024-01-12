import 'package:flutter_xspend/src/models/category.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'transaction_service.dart';

class TransactionController {
  static isValid(category, amount, date) {
    return category != null && amount != '' && double.parse(amount) > 0 && date != null;
  }

  static create(category, amount, date, note, currency) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        print('== connect to API ==');
      }
      catch (error) {
        print('= create transaction error = $error');
        TransactionService.createNewInLocal(category, amount, date, note, currency, false);
      }
    }
    else {
      TransactionService.createNewInLocal(category, amount, date, note, currency, false);
    }
  }
}