import 'package:flutter_xspend/src/models/category.dart';
import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'transaction_service.dart';
import 'package:flutter_xspend/src/utils/api_response_util.dart';

class TransactionController {
  static isValid(category, amount, date) {
    return category != null && amount != '' && double.parse(amount) > 0 && date != null;
  }

  static create(Transaction transaction, successCallback, failureCallback) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        print('== connect to API ==');
        final response = TransactionService.sendCreateRequst(transaction);
        ApiResponseUtil.handleResponse(response, () {
          Transaction.update(transaction.id, { 'synced': true });
          successCallback?.call();
        }, (errorMsg) {
          failureCallback?.call('Failed to create new transaction.');
        });
      }
      catch (error) {
        print('= create transaction error = $error');
        TransactionService.createNewInLocal(transaction);
        failureCallback?.call('Failed to create new transaction.');
      }
    }
    else {
      TransactionService.createNewInLocal(transaction);
    }
  }
}