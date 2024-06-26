import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:flutter_xspend/src/sign_up/sign_up_service.dart';
import 'package:flutter_xspend/src/utils/api_response_util.dart';
import 'package:flutter_xspend/src/models/user.dart';

class SignUpController {
  static Future<void> signUp(name, email, password, successCallback, failureCallback) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!await User.isExisted(email)) {
      _createUser(name, email, password);
      const uuid = Uuid();
      await prefs.setString('TOKEN', uuid.v4());
      successCallback?.call();
      successCallback?.call();
      return;
    }
    failureCallback?.call('User is already existed.');


    // if (await InternetConnectionChecker().hasConnection) {
    //   try {
    //     final response = await SignUpService().register(name, email, password);
    //     ApiResponseUtil.handleResponse(response, () async {
    //       await prefs.setString('TOKEN', jsonDecode(response.body)['access_token']);
    //       _createUser(name, email, password);
    //       successCallback?.call();
    //     }, (errorMsg) {
    //       failureCallback?.call('Failed to sign up. Please try again.');
    //     });
    //   }
    //   catch(error) {
    //     failureCallback?.call('Failed to sign up new account.');
    //   }
    // }
    // else {
    //   if (!await User.isExisted(email)) {
    //     _createUser(name, email, password);
    //     const uuid = Uuid();
    //     await prefs.setString('TOKEN', uuid.v4());
    //     successCallback?.call();
    //     successCallback?.call();
    //     return;
    //   }
    //   failureCallback?.call('User is already existed.');
    // }
  }

  static void _createUser(name, email, password) {
    const uuid = Uuid();
    User.create(
      User()
        ..id = uuid.v4()
        ..name = name
        ..email = email
        ..password = password
        ..loggedIn = true
    );
  }
}