import 'package:flutter_xspend/src/sign_up/sign_up_service.dart';
import 'package:flutter_xspend/src/utils/api_response_util.dart';

class SignUpController {
  static Future<void> signUp(name, email, password, successCallback, failureCallback) async {
    try {
      final response = await SignUpService().register(name, email, password);
      ApiResponseUtil.handleResponse(response, () async {
        successCallback?.call(response);
      }, (errorMsg) {
        failureCallback?.call('Failed to sign up. Please try again.');
      });
    }
    catch(error) {
      print('++++ errro = $error');

      failureCallback('Failed to sign up new account.');
    }
  }
}