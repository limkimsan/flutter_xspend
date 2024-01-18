part of 'exchange_rate_bloc.dart';

class ExchangeRateEvent {
  const ExchangeRateEvent();
}

class UpdateExchangeRate extends ExchangeRateEvent {
  const UpdateExchangeRate({ this.exchangeRate = defaultExchangeRate });
  final Map<String, int> exchangeRate;
}