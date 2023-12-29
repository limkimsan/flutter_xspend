import 'package:isar/isar.dart';

import 'package:flutter_xspend/src/utils/fast_hash_util.dart';
import 'package:flutter_xspend/src/isar/isar_service.dart';

part 'user.g.dart';

@collection
class User {
  String? id;
  Id get isarId => fastHash(id!);
  String? name;
  String? email;
  String? password;
  bool? loggedIn;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'loggedIn': loggedIn,
    };
  }

  static fromJson(Map<String, dynamic> json) {
    return User()
            ..id = json['id']
            ..name = json['name']
            ..email = json['email']
            ..password = json['password']
            ..loggedIn = json['loggedIn'];
  }

  static create(User newUser) async {
    final isar = await IsarService().getDB();
    isar.writeTxnSync(() {
      isar.users.putSync(newUser);
    });
  }

  static Future currentLoggedIn() async {
    final isar = await IsarService().getDB();
    return await isar.users.filter().loggedInEqualTo(true).findFirst();
  }

  static update(id, Map<String, dynamic> params) async {
    final isar = await IsarService().getDB();
    User? user = await isar.users.get(id);
    if (user != null) {
      Map<String, dynamic> newUser = user.toMap();
      params.forEach((key, value) {
        newUser[key] = value;
      });
      User formattedParams = User.fromJson(newUser);
      isar.writeTxnSync(() {
        isar.users.putSync(formattedParams);
      });
    }
  }

  static markAsLoggedIn(id) {
    update(id, {'loggedIn': true});
  }

  static markAsLoggedOut(id) {
    update(id, {'loggedIn': false});
  }

  static isAuthenticationMatched(email, password) async {
    final isar = await IsarService().getDB();
    User? user = await isar.users.filter().emailEndsWith(email).and().passwordEqualTo(password).findFirst();
    return user != null ? true : false;
  }
}