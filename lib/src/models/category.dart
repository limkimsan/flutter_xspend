import 'package:isar/isar.dart';

import 'package:flutter_xspend/src/utils/fast_hash_util.dart';
import 'package:flutter_xspend/src/isar/isar_service.dart';

part 'category.g.dart';

@collection
class Category {
  String? id;
  Id get isarId => fastHash(id!);
  String? name;
  int? transactionType;
  int? order;
  String? icon;
  String? iconType;
  String? iconColor;
  String? bgColor;

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'transactionType': transactionType,
  //     'order': order,
  //     'icon': icon,
  //     'iconType': iconType,
  //     'iconColor': iconColor,
  //     'bgColor': bgColor
  //   };
  // }

  // fromJson(Map<String, dynamic> json) {
  //   return Category()
  //           ..id = json['id']
  //           ..name = json['name']
  //           ..transactionType = json['transactionType']
  //           ..order = json['order']
  //           ..icon = json['icon']
  //           ..iconType = json['iconType']
  //           ..iconColor = json['iconColor']
  //           ..bgColor = json['bgColor'];
  // }

  static create(Category newCate) async {
    final isar = await IsarService().getDB();
    isar.writeTxnSync(() {
      isar.categorys.putSync(newCate);
    });
  }

  static expenseCategories() async {
    final isar = await IsarService().getDB();
    return await isar.categorys.filter().transactionTypeEqualTo(1).findAll();
  }

  static incomeCategoies() async {
    final isar = await IsarService().getDB();
    return await isar.categorys.filter().transactionTypeEqualTo(0).findAll();
  }
}