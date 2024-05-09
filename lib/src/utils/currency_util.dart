import 'package:intl/intl.dart';
import 'package:flutter_xspend/src/localization/localization_service.dart';

class CurrencyUtil {
  // curencyType is the tyoe of the currency that was used in the transaction
  static getKHR(amount, currencyType, exchangeRates) {
    return currencyType.toLowerCase() == 'khr' ? amount : amount * exchangeRates['khr'];
  }

  static getUSD(amount, currencyType, exchangeRates) {
    return currencyType.toLowerCase() == 'usd' ? amount : amount / exchangeRates['khr'];
  }

  static formatNumber(String value) => NumberFormat.decimalPattern('en').format(double.parse(value)).replaceAll(",", " ");  // Group the number by space

  static getCurrencyFormat(value, currencyType) {
    if (currencyType == 'khr') {
      return  NumberFormat.currency(
        symbol: '៛',
      ).format(value);
    }

    return NumberFormat.currency(
      symbol: '\$',
    ).format(value);
  }

  static String getKFormat(number, currencyType) {
    final formatter = NumberFormat.compact(locale: LocalizationService.currentLanguage == 'km' ? 'km' : 'en_US', explicitSign: false);
    return '${currencyType == 'khr' ? '៛' : "\$"}${formatter.format(number)}';
  }
}