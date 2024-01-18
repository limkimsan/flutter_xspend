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
    // save new transaction in local
    Transaction.create(transaction);
    successCallback?.call();

    // if (await InternetConnectionChecker().hasConnection) {
    //   try {
    //     final response = await TransactionService.sendCreateRequest(transaction);
    //     ApiResponseUtil.handleResponse(response, () {
    //       transaction.synced = true;
    //       Transaction.create(transaction);
    //       successCallback?.call();
    //     }, (errorMsg) {
    //       failureCallback?.call('Failed to create new transaction.');
    //     });
    //   }
    //   catch (error) {
    //     print('= create transaction error = $error');
    //     Transaction.create(transaction);
    //     failureCallback?.call('Failed to create new transaction.');
    //   }
    // }
    // else {
    //   Transaction.create(transaction);
    //   successCallback?.call();
    // }
  }

  static update(Transaction transaction, successCallback) {
    Transaction.update(transaction.id, {
      'amount': transaction.amount,
      'currencyType': transaction.currencyType,
      'note': transaction.note,
      'transactionType': transaction.transactionType,
      'transactionDate': transaction.transactionDate,
      'category': transaction.category,
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      loadTransactions((transactions) => {successCallback?.call(transactions)});
    });
  }

  static delete(String id, successCallback) {
    Transaction.deleteById(id);
    Future.delayed(const Duration(milliseconds: 100), () {
      loadTransactions((transactions) => {successCallback?.call(transactions)});
    });
  }

  static loadTransactions(successCallback, [failureCallback]) async {
    final transactions = await Transaction.getAllByDurationType('month');
    successCallback?.call(transactions);
  }

  static getTransactionDetail(id, callback) async {
    final transaction = await Transaction.findById(id);
    callback?.call(transaction);
  }
}