import 'package:flutter_xspend/src/isar/isar_service.dart';
import 'package:isar/isar.dart';

import 'category.dart';
import 'user.dart';
import 'package:flutter_xspend/src/utils/fast_hash_util.dart';

part 'transaction.g.dart';

@collection
class Transaction {
  String? id;
  Id get isarId => fastHash(id!);
  double? amount;
  String? currencyType;
  String? note;
  int? transactionType;
  DateTime? transactionDate;
  bool? synced;
  final category = IsarLink<Category>();
  final user = IsarLink<User>();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'currencyType': currencyType,
      'note': note,
      'transactionType': transactionType,
      'transactionDate': transactionDate,
      'synced': synced,
      'category': category,
      'user': user,
    };
  }

  static fromJson(Map<String, dynamic> json) {
    return Transaction()
            ..id = json['id']
            ..amount = json['amount']
            ..currencyType = json['currencyType']
            ..note = json['note']
            ..transactionType = json['transactionType']
            ..transactionDate = json['transactionDate']
            ..synced = json['synced']
            ..category.value = json['category'].value
            ..user.value = json['user'].value;
  }

  static create(Transaction newTransaction) async {
    final isar = await IsarService().getDB();
    isar.writeTxnSync(() {
      isar.transactions.putSync(newTransaction);
    });
  }

  static update(id, Map<String, dynamic> params) async {
    final isar = await IsarService().getDB();
    Transaction? transaction = await isar.transactions.get(id);
    if (transaction != null) {
      Map<String, dynamic> newTransaction = transaction.toMap();
      params.forEach((key, value) {
        newTransaction[key] = value;
      });
      Transaction formattedParams = Transaction.fromJson(newTransaction);
      isar.writeTxnSync(() {
        isar.transactions.putSync(formattedParams);
      });
    }
  }
}