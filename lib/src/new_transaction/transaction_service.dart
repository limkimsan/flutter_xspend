import 'package:uuid/uuid.dart';

import 'package:flutter_xspend/src/models/category.dart';
import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:flutter_xspend/src/models/user.dart';

class TransactionService {
  // static sendCreateRequst() {

  // }

  static createNewInLocal(category, amount, date, note, currency, synced) {
    const uuid = Uuid();
    final transaction = Transaction()
                          ..id = uuid.v4()
                          ..amount = double.parse(amount)
                          ..currencyType = currency
                          ..note = note
                          ..transactionType = category.transactionType
                          ..transactionDate = date
                          ..synced = synced
                          ..category.value = category
                          ..user.value = User.currentLoggedIn() as User?;

    Transaction.create(transaction);
  }
}