import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_xspend/src/constants/transaction_constant.dart';

part 'exchange_rate_event.dart';
part 'exchange_rate_state.dart';

class ExchangeRateBloc extends Bloc<ExchangeRateEvent, ExchangeRateState> {
  ExchangeRateBloc() : super(ExchangeRateInitialState()) {
    on<UpdateExchangeRate>(_onUpdateExchangeRate);
  }

  void _onUpdateExchangeRate(UpdateExchangeRate event, Emitter<ExchangeRateState> emit) {
    emit(ExchangeRateLoadedState(newExchangeRate: event.exchangeRate));
  }
}