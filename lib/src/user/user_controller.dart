import 'dart:convert';

import 'package:uuid/uuid.dart';

import 'user_service.dart';
import 'package:flutter_xspend/src/models/user.dart';

class UserController {
  static handleCreateUpdateUser(email, successCallback) async {
    final response = await UserService.getDetail(email);
    final user = await User.findByEmail(email);
    final userInfo = jsonDecode(response.body);

    if (user == null) {
      const uuid = Uuid();
      User.create(
        User()
          ..id = uuid.v4()
          ..name = userInfo['name']
          ..email = email
          ..password = userInfo['password']
          ..loggedIn = true
          ..serverId = userInfo['id']
      );
      successCallback?.call();
    }
    else {
      User.update(user.id, { 'serverId': userInfo['id'] });
      successCallback?.call();
    }
  }
}