class CurrencyUtil {
  // curencyType is the tyoe of the currency that was used in the transaction
  static getKHR(amount, currencyType, exchangeRates) {
    // return currencyType.toLowerCase() == 'khr' ? double.parse(amount) : double.parse(amount) * exchangeRates.khr;
    return currencyType.toLowerCase() == 'khr' ? amount : amount * exchangeRates['khr'];
  }

  static getUSD(amount, currencyType, exchangeRates) {
    return currencyType.toLowerCase() == 'usd' ? amount : amount / exchangeRates['khr'];
    // return currencyType == 'usd' ? double.parse(amount) : double.parse(amount) / exchangeRates.khr;
  }
}