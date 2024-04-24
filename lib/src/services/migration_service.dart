import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_xspend/src/migrate/category_migration.dart';

class MigrationService {
  static performMigration() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final migrationVersion = prefs.getInt('MIGRATION_VERSION');

    switch (migrationVersion) {
      case 1 || null:
        CategoryMigration.migrateDefaultNameKm();
        await prefs.setInt('MIGRATION_VERSION', 2);
        break;
      default:
        return;
    }
  }
}