part of 'budget_bloc.dart';

class BudgetEvent {
  const BudgetEvent();
}

class LoadBudget extends BudgetEvent {
  const LoadBudget({ this.budgets = const <Budget> [] });
  final List<Budget> budgets;
}