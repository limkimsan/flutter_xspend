import 'package:equatable/equatable.dart';

import 'package:flutter_xspend/src/models/budget.dart';

class BudgetState extends Equatable {
  const BudgetState({ required this.budgets, required this.tranList });
  final List<Budget> budgets;
  final List tranList;

  @override
  List<Object> get props => [budgets, tranList];
}

class BudgetInitialState extends BudgetState {
  BudgetInitialState() : super(budgets: <Budget>[], tranList: []);

  @override
  List<Object> get props => [[], []];
}

class BudgetLoadedState extends BudgetState {
  const BudgetLoadedState({ required this.newBudgets, required this.newTranList }) : super(budgets: newBudgets, tranList: newTranList);
  final List<Budget> newBudgets;
  final List newTranList;

  @override
  List<Object> get props => [newBudgets, newTranList];
}