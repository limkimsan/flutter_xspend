import 'package:flutter_bloc/flutter_bloc.dart';

part 'base_currency_event.dart';
part 'base_currency_state.dart';

class BaseCurrencyBloc extends Bloc<BaseCurrencyEvent, BaseCurrencyState> {
  BaseCurrencyBloc() : super(BaseCurrencyInitialState()) {
    on<UpdateBaseCurrency>(_onUpdateBaseCurrency);
  }

  void _onUpdateBaseCurrency(UpdateBaseCurrency event, Emitter<BaseCurrencyState> emit) {
    emit(BaseCurrencyLoadedState(newCurrency: event.currency));
  }
}