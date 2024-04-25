part of 'budget_bloc.dart';

class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object> get props => [[], []];
}

class LoadBudget extends BudgetEvent {
  const LoadBudget({ this.budgets = const <Budget> [], this.tranList = const [] });
  final List<Budget> budgets;
  final List tranList;

  @override
  List<Object> get props => [budgets, tranList];
}