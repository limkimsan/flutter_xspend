part of 'exchange_rate_bloc.dart';

class ExchangeRateState {
  const ExchangeRateState({ required this.exchangeRate });
  final Map<String, int> exchangeRate;
}

class ExchangeRateInitialState extends ExchangeRateState {
  ExchangeRateInitialState() : super(exchangeRate: defaultExchangeRate);
}

class ExchangeRateLoadedState extends ExchangeRateState {
  ExchangeRateLoadedState({ required this.newExchangeRate }) : super(exchangeRate: newExchangeRate);
  final Map<String, int> newExchangeRate;
}