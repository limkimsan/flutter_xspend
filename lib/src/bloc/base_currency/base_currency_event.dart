part of 'base_currency_bloc.dart';

class BaseCurrencyEvent {
  const BaseCurrencyEvent();
}

class UpdateBaseCurrency extends BaseCurrencyEvent {
  const UpdateBaseCurrency({this.currency = 'khr'});
  final String currency;
}
