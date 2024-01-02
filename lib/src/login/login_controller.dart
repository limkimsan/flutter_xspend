import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:flutter_xspend/src/login/login_service.dart';
import 'package:flutter_xspend/src/utils/api_response_util.dart';
import 'package:flutter_xspend/src/models/user.dart';

class LoginController {
  static Future<void> login(email, password, successCallback, failureCallback) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final response = await LoginService().authenticate(email, password);
        ApiResponseUtil.handleResponse(response, () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('TOKEN', jsonDecode(response.body)['access_token']);
          successCallback?.call();
        }, (errorMsg) {
          failureCallback?.call('Failed to login.');
        });
      } catch (error) {
        failureCallback?.call('Failed to login.');
      }
    }
    else {
      if (User.isAuthenticationMatched(email, password)) {
        successCallback?.call();
      }
      else {
        failureCallback?.call('User is not existed.');
      }
    }
  }
}