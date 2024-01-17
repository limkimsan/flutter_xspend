import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:flutter_xspend/src/login/login_service.dart';
import 'package:flutter_xspend/src/utils/api_response_util.dart';
import 'package:flutter_xspend/src/models/user.dart';
import 'package:flutter_xspend/src/user/user_controller.dart';
import 'package:flutter_xspend/src/login/login_view.dart';

class LoginController {
  static Future<void> login(email, password, successCallback, failureCallback) async {
    if (await InternetConnectionChecker().hasConnection) {
      try {
        final response = await LoginService().authenticate(email, password);
        ApiResponseUtil.handleResponse(response, () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('TOKEN', jsonDecode(response.body)['access_token']);

          // Check if the user is not existed then create new
          // If the user is already existed then update the serverId of the existing user
          UserController.handleCreateUpdateUser(email, () {
            successCallback?.call();
          });
        }, (errorMsg) {
          failureCallback?.call('Failed to login.');
        });
      } catch (error) {
        failureCallback?.call('Failed to login.');
      }
    }
    else {
      if (await User.isAuthenticationMatched(email, password)) {
        final user = await User.findByEmail(email);
        User.markAsLoggedIn(user.id);
        successCallback?.call();
      }
      else {
        failureCallback?.call('User is not existed.');
      }
    }
  }

  static logout(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('TOKEN');
    final user = await User.currentLoggedIn();
    User.markAsLoggedOut(user.id);
    Navigator.pushNamedAndRemoveUntil(context, LoginView.routeName, (route) => false);
  }
}