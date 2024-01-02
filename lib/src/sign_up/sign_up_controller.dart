import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_xspend/src/sign_up/sign_up_service.dart';
import 'package:flutter_xspend/src/utils/api_response_util.dart';
import 'package:flutter_xspend/src/models/user.dart';

class SignUpController {
  static Future<void> signUp(name, email, password, successCallback, failureCallback) async {
    try {
      final response = await SignUpService().register(name, email, password);
      ApiResponseUtil.handleResponse(response, () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('TOKEN', jsonDecode(response.body)['access_token']);
        const uuid = Uuid();
        User.create(
          User()
          ..id = uuid.v4().toString()
          ..name = name
          ..email = email
          ..password = password
          ..loggedIn = true
        );
        successCallback?.call();
      }, (errorMsg) {
        failureCallback?.call('Failed to sign up. Please try again.');
      });
    }
    catch(error) {
      failureCallback('Failed to sign up new account.');
    }
  }
}