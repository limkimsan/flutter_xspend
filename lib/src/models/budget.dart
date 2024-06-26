import 'package:flutter_xspend/src/isar/isar_service.dart';
import 'package:isar/isar.dart';

import 'package:flutter_xspend/src/models/user.dart';
import 'package:flutter_xspend/src/utils/fast_hash_util.dart';

part 'budget.g.dart';

@collection
class Budget {
  String? id;
  Id get isarId => fastHash(id!);
  String? name;
  double? amount;
  DateTime? startDate;
  DateTime? endDate;
  String? currencyType;
  final user = IsarLink<User>();

  @override
  String toString() => 'Budget(id: $id, name: $name, amount: $amount, startDate: $startDate, endDate: $endDate, currencyType: $currencyType, user: $user)';

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "amount": amount,
      "startDate": startDate,
      "endDate": endDate,
      "currencyType": currencyType,
      "user": user
    };
  }

  static fromJson(Map<String, dynamic> json) {
    return Budget()
            ..id = json['id']
            ..name = json['name']
            ..amount = json['amount']
            ..startDate = json['startDate']
            ..endDate = json['endDate']
            ..currencyType = json['currencyType']
            ..user.value = json['user'].value;
  }

  static create(Budget newBudget) async {
    final isar = await IsarService().getDB();
    isar.writeTxnSync(() {
      isar.budgets.putSync(newBudget);
    });
  }

  static getAllOfCurrentUser() async {
    final user = await User.currentLoggedIn();
    final isar = await IsarService().getDB();
    List budgets = await isar.budgets.filter().user((q) => q.idEqualTo(user.id)).sortByStartDate().findAll();
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    // This code will sort the budgets that passed to the bottom of the list
    // The budgets..sort will sort and return the sorted array
    return budgets..sort((a, b) {
      return a.endDate.isBefore(today) ? 1 : -1;
    });

    // The budgets.sort will not return the sorted array, it is updating the budgets, so we need to return the budgets at the end
    // budgets.sort((a, b) {
    //   return a.endDate.isBefore(today) ? 1 : -1;
    // });

    // return budgets;
  }

  static findById(String id) async {
    final isar = await IsarService().getDB();
    return await isar.budgets.filter().idEqualTo(id).findFirst();
  }

  static update(id, Map<String, dynamic> params) async {
    final isar = await IsarService().getDB();
    Budget? budget = await findById(id);
    if (budget != null) {
      Map<String, dynamic> newBudget = budget.toMap();
      params.forEach((key, value) {
        newBudget[key] = value;
      });
      Budget formattedParams = Budget.fromJson(newBudget);
      isar.writeTxnSync(() {
        isar.budgets.putSync(formattedParams);
      });
    }
  }

  static deleteById(String id) async {
    final isar = await IsarService().getDB();
    isar.writeTxn(() async {
      await isar.budgets.filter().idEqualTo(id).deleteAll();
    });
  }
}