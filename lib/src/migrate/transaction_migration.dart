import 'package:isar/isar.dart';

import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:flutter_xspend/src/isar/isar_service.dart';

class TransactionMigration {
  static migrateTransactionDate() async {
    final isar = await IsarService().getDB();
    final isarTransactions = await isar.transactions.where().findAll();

    if (isarTransactions.isNotEmpty) {
      isar.writeTxnSync(() async {
        for (final transaction in isarTransactions) {
          final tranJson = transaction.toMap();
          final previousDate = tranJson['transactionDate'];
          final now = DateTime.now();
          tranJson['transactionDate'] = DateTime(
              previousDate.year,
              previousDate.month,
              previousDate.day,
              now.hour,
              now.minute,
              now.second,
              999);
          Transaction newTran = Transaction.fromJson(tranJson);
          isar.transactions.putSync(newTran);
        }
      });
    }
  }
}
