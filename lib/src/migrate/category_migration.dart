import 'package:isar/isar.dart';

import 'package:flutter_xspend/src/models/category.dart';
import 'package:flutter_xspend/src/isar/isar_service.dart';
import 'package:flutter_xspend/src/data/categories.dart';

class CategoryMigration {
  static migrateDefaultNameKm() async {
    final isar = await IsarService().getDB();
    final isarCategories = await isar.categorys.where().findAll();
    List deleteCates = [];

    isar.writeTxnSync(() async {
      for (final category in isarCategories) {
        final int index = categories.indexWhere((element) => element.id == category.id);
        if (index != -1) {
          final cateJson = category.toMap();
          cateJson['nameKm'] = categories[index].nameKm;
          Category newCate = Category.fromJson(cateJson);
          isar.categorys.putSync(newCate);
        }
        else {
          deleteCates.add(category);
        }
      }
    });

    if (deleteCates.isNotEmpty) {
      isar.writeTxnSync(() {
        for (final cate in deleteCates) {
          isar.categorys.filter().idEqualTo(cate.id).deleteFirstSync();
        }
      });
    }
  }
}