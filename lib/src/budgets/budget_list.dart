import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_xspend/src/bloc/exchange_rate/exchange_rate_bloc.dart';
import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/bloc/budget/budget_bloc.dart';
import 'budget_calculation_service.dart';
import 'budget_empty_message.dart';
import 'budget_list_item.dart';
import 'budget_controller.dart';

class BudgetList extends StatefulWidget {
  const BudgetList({super.key});

  @override
  State<BudgetList> createState() => _BudgetListState();
}

class _BudgetListState extends State<BudgetList> {
  List transactionList = [];

  @override
  void initState() {
    super.initState();
    BudgetController.loadBudgets((budgets, tranList) {
      context.read<BudgetBloc>().add(LoadBudget(budgets: budgets, tranList: tranList));
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ExchangeRateBloc>().state;
    final budgetState = context.watch<BudgetBloc>().state;

    Widget listItem(index) {
      final budget = budgetState.budgets[index];
      final budgetCal = BudgetCalculationService(budget, budgetState.tranList[index], state.exchangeRate);
      final Map<String, dynamic> progress = budgetCal.getProgress();

      return Column(
        children: [
          BudgetListItem(
            budget: budget,
            progress: progress,
            reloadBudgets: (newBudgets, newTranList) {
              context.read<BudgetBloc>().add(LoadBudget(budgets: newBudgets, tranList: newTranList));
            }
          ),
          const Divider(color: grey, height: 1)
        ],
      );
    }

    if (budgetState.budgets.isEmpty) {
      return const BudgetEmptyMessage();
    }

    return ListView.builder(
      itemCount: budgetState.budgets.length,
      itemBuilder: (context, index) {
        return listItem(index);
      }
    );
  }
}