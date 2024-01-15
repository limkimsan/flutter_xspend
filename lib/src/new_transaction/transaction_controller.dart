import 'package:collection/collection.dart';

import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'transaction_service.dart';
import 'package:flutter_xspend/src/utils/api_response_util.dart';
import 'package:flutter_xspend/src/helpers/transaction_helper.dart';

class TransactionController {
  static isValid(category, amount, date) {
    return category != null && amount != '' && double.parse(amount) > 0 && date != null;
  }

  static create(Transaction transaction, successCallback, failureCallback) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final response = await TransactionService.sendCreateRequest(transaction);
        ApiResponseUtil.handleResponse(response, () {
          transaction.synced = true;
          Transaction.create(transaction);

          successCallback?.call();
        }, (errorMsg) {
          failureCallback?.call('Failed to create new transaction.');
        });
      }
      catch (error) {
        print('= create transaction error = $error');
        Transaction.create(transaction);
        failureCallback?.call('Failed to create new transaction.');
      }
    }
    else {
      Transaction.create(transaction);
    }
  }

  static loadTransactions(successCallback, [failureCallback]) async {
    final transactions = await Transaction.getAllByDurationType('month');
    successCallback?.call(transactions);
  }

  static getGroupedTransactions() async {
    final transactions = await Transaction.getAllByDurationType('month');
    final groupedList = groupBy(transactions, (t) => (t as Transaction).transactionDate);
    final formattedList = [];
    groupedList.forEach((key, value) {
      final obj = {
        'title': {'date': key.toString(), 'total': TransactionHelper.getFormattedTotal(value)},
        'data': value,
      };
      formattedList.add(obj);
    });
    return formattedList;
  }
}