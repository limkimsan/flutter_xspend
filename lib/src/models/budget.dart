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

  static create(Budget newBudget) async {
    final isar = await IsarService().getDB();
    isar.writeTxnSync(() {
      isar.budgets.putSync(newBudget);
    });
  }

  static getAllOfCurrentUser() async {
    final user = await User.currentLoggedIn();
    final isar = await IsarService().getDB();
    return await isar.budgets.filter().user((q) => q.idEqualTo(user.id)).findAll();
  }
}