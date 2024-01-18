part of 'base_currency_bloc.dart';

class BaseCurrencyState {
  const BaseCurrencyState({ required this.currency });
  final String currency;
}

class BaseCurrencyInitialState extends BaseCurrencyState {
  BaseCurrencyInitialState() : super(currency: 'khr');
}

class BaseCurrencyLoadedState extends BaseCurrencyState {
  BaseCurrencyLoadedState({ required this.newCurrency }) : super(currency: newCurrency);
  final String newCurrency;
}