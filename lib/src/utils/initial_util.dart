import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_xspend/src/constants/transaction_constant.dart';

class InitialUtil {
  static loadCurrencyAndExchangeRate(callback) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final khrRate = prefs.getInt('KHR_RATE');
    final usdRate = prefs.getInt('USD_RATE');
    final basedCurrency = prefs.getString('BASED_CURRENCY');

    if (khrRate == null) {
      await prefs.setInt('KHR_RATE', defaultExchangeRate['khr'] as int);
      await prefs.setInt('USD_RATE', defaultExchangeRate['usd'] as int);
    }
    if (basedCurrency == null) {
      await prefs.setString('BASED_CURRENCY', 'khr');
    }

    callback(
      khrRate,
      usdRate,
      basedCurrency
    );
  }
}