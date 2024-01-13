import 'package:isar/isar.dart';

import 'package:flutter_xspend/src/utils/fast_hash_util.dart';
import 'package:flutter_xspend/src/isar/isar_service.dart';
import 'package:flutter_xspend/src/data/categories.dart';

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

  Category(this.id, this.name, this.transactionType, this.order,  this.icon, this.iconType, this.iconColor, this.bgColor);

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

  static seedData() async {
    final isar = await IsarService().getDB();
    List<Category> items = await isar.categorys.where().findAll();
    if (items.isNotEmpty) {
      return;
    }

    isar.writeTxnSync(() {
      for (final category in categories) {
        isar.categorys.putSync(category);
      }
    });
  }

  static create(Category newCate) async {
    final isar = await IsarService().getDB();
    isar.writeTxnSync(() {
      isar.categorys.putSync(newCate);
    });
  }

  static Future <List<Category>> expenseCategories() async {
    final isar = await IsarService().getDB();
    return await isar.categorys.filter().transactionTypeEqualTo(1).findAll();
  }

  static incomeCategoies() async {
    final isar = await IsarService().getDB();
    return await isar.categorys.filter().transactionTypeEqualTo(0).findAll();
  }
}