import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_xspend/src/web/web_service.dart';
import 'package:flutter_xspend/src/utils/url_util.dart';

class SignUpService {
  Future register(String name, String email, String password) async {
    final url = Uri.parse(UrlUtil.absoluteUrl(UrlUtil.relativeUrl('users')));
    final params = {
      'name': name,
      'email': email,
      'password': password,
      'grant_type': 'client_credentials',
      'client_id': dotenv.env['CLIENT_ID'],
      'client_secret': dotenv.env['CLIENT_SECRET']
    };
    return await WebService().post(url, params);
  }
}