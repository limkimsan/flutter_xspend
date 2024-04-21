import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_xspend/src/models/budget.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  BudgetBloc() : super(BudgetInitialState()) {
    on<LoadBudget>(_onLoadBudget);
  }

  void _onLoadBudget(LoadBudget event, Emitter<BudgetState> emit) {
    emit(BudgetLoadedState(newBudgets: event.budgets));
  }
}