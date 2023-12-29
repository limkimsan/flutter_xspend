import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_xspend/src/models/user.dart';

class IsarService {
  // Singleton instance variable
  static final IsarService _instance = IsarService._privateConstructor();

  // private constructor to prevent instantiation from outside
  IsarService._privateConstructor() {
    _db = openDB();
  }

  // Factory constructor to return the singleton instance
  factory IsarService() {
    return _instance;
  }

  late Future<Isar>
      _db; // equal to: late Future<Isar> db; (we use ? or late becuase db is not a nullable argument)

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final Directory dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [UserSchema],
        directory: dir.path,
        // inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<Isar> getDB() {
    return _db;
  }
}
