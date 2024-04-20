part of 'budget_bloc.dart';

class BudgetState {
  const BudgetState({ required this.budgets });
  final List<Budget> budgets;
}

class BudgetInitialState extends BudgetState {
  BudgetInitialState() : super(budgets: <Budget>[]);
}

class BudgetLoadedState extends BudgetState {
  BudgetLoadedState({ required this.newBudgets }) : super(budgets: newBudgets);
  final List<Budget> newBudgets;
}