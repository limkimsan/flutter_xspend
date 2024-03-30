import 'package:intl/intl.dart';

class CurrencyUtil {
  // curencyType is the tyoe of the currency that was used in the transaction
  static getKHR(amount, currencyType, exchangeRates) {
    return currencyType.toLowerCase() == 'khr' ? amount : amount * exchangeRates['khr'];
  }

  static getUSD(amount, currencyType, exchangeRates) {
    return currencyType.toLowerCase() == 'usd' ? amount : amount / exchangeRates['khr'];
  }

  static formatNumber(String value) => NumberFormat.decimalPattern('en').format(double.parse(value)).replaceAll(",", " ");  // Group the number by space
}