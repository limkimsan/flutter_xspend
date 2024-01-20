import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_xspend/src/models/transaction.dart';

import 'transaction_state.dart';

part 'transaction_event.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitialState()) {
    on<LoadTransaction>(_onLoadTransaction);
    on<AddNewTransaction>(_onAddNewTransaction);
  }

  void _onLoadTransaction(LoadTransaction event, Emitter<TransactionState> emit) {
    emit(TransactionLoadedState(newTransactions: event.transactions));
  }

  void _onAddNewTransaction(AddNewTransaction event, Emitter<TransactionState> emit) {
    if (state is TransactionLoadedState) {
      final state = this.state as TransactionLoadedState;
      emit(TransactionLoadedState(newTransactions: List.from(state.transactions)..add(event.transaction)));
    }
  }
}