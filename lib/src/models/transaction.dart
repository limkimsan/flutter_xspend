import 'package:intl/intl.dart';
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
    Transaction? transaction = await findById(id);
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

  static findById(String id) async {
    final isar = await IsarService().getDB();
    return await isar.transactions.filter().idEqualTo(id).findFirst();
  }

  static void deleteById(String id) async {
    final isar = await IsarService().getDB();
    isar.writeTxn(() async {
      await isar.transactions.filter().idEqualTo(id).deleteAll();
    });
  }

  static deleteByDateRange(startDate, endDate) async {
    List transactions = await getAllByDurationType('custom', startDate.toString(), endDate.toString());
    if (transactions.isNotEmpty) {
      for (var transaction in transactions) {
        deleteById(transaction.id);
      }
    }
  }

  static getAllOfCurrentUser() async {
    final user = await User.currentLoggedIn();
    final isar = await IsarService().getDB();
    return await isar.transactions.filter().user((q) => q.idEqualTo(user.id)).findAll();
  }

  static getAllByDurationType(String type, [String? customStartDate, String? customEndDate]) async {
    DateTime now = DateTime.now();
    DateTime startDate = DateTime(now.year, now.month, 1);
    DateTime startOfNextMonth = DateTime(now.year, now.month + 1, 1);
    DateTime endDate = startOfNextMonth.subtract(const Duration(days: 1));

    if (type == 'custom') {
      startDate = DateTime.parse(customStartDate as String);
      endDate = DateTime.parse(customEndDate as String);
    }
    else if (type == 'week') {
      startDate = now.subtract(Duration(days: now.weekday - DateTime.monday));
      endDate = now.add(Duration(days: DateTime.sunday - now.weekday));
    }
    else if (type == 'year') {
      startDate = DateTime(now.year, 1, 1);
      DateTime startOfNextYear = DateTime(now.year + 1, 1, 1);
      endDate = startOfNextYear.subtract(const Duration(days: 1));
    }

    final user = await User.currentLoggedIn();
    final isar = await IsarService().getDB();
    final result = await isar.transactions.filter().transactionDateBetween(startDate, endDate).and().user((q) => q.idEqualTo(user.id)).sortByTransactionDateDesc().findAll();
    return result;
  }

  static getAllByMonth(selectedDate) async {
    DateTime startOfNextMonth = DateTime(selectedDate.year, selectedDate.month + 1, 1);
    return await getAllByDurationType(
                    'custom',
                    DateTime(selectedDate.year, selectedDate.month, 1).toString(),
                    startOfNextMonth.subtract(const Duration(days: 1)).toString()
                  );
  }
}