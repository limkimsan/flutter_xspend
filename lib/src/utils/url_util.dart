import 'package:flutter_dotenv/flutter_dotenv.dart';

class UrlUtil {
  static String relativeUrl(responsibleModel) {
    return "/api/${dotenv.env['API_VERSION']}/$responsibleModel";
  }

  static String absoluteUrl(relativeUrl) {
    if (relativeUrl.isEmpty) {
      return '';
    }

    return "${dotenv.env['DOMAIN']}$relativeUrl";
  }
}