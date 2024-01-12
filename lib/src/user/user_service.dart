import 'package:flutter_xspend/src/web/web_service.dart';
import 'package:flutter_xspend/src/utils/url_util.dart';

class UserService {
  static getDetail(email) async {
    final baseUrl = UrlUtil.absoluteUrl(UrlUtil.relativeUrl('user_detail'));
    final queryParams = {'email': email};
    final url = Uri.parse(baseUrl).replace(queryParameters: queryParams);
    return await WebService(isTokenBased:  true).get(url);
  }
}