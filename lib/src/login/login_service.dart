import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_xspend/src/utils/url_util.dart';
import 'package:flutter_xspend/src/web/web_service.dart';

class LoginService {
  Future authenticate(String email, String password)  async {
    final url = Uri.parse(UrlUtil.absoluteUrl('/oauth/token'));
    final params = {
      'email': email,
      'password': password,
      'grant_type': 'password',
      'client_id': dotenv.env['CLIENT_ID'],
      'client_secret': dotenv.env['CLIENT_SECRET'],
    };
    return await WebService().post(url, params);
  }
}