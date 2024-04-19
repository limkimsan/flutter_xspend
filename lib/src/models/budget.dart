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
}