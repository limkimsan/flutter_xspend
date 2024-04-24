import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'budget_list.dart';
import 'new_budget_view.dart';
import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/bloc/budget/budget_bloc.dart';

class BudgetView extends StatefulWidget {
  const BudgetView({super.key, required this.budgetBloc});

  final BudgetBloc budgetBloc;

  @override
  State<BudgetView> createState() => _BudgetViewState();
}

class _BudgetViewState extends State<BudgetView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.budgetBloc,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(AppLocalizations.of(context)!.budget)
        ),
        body: const BudgetList(),
        floatingActionButton: SizedBox(
          height: 56,
          width: 56,
          child: FloatingActionButton(
            foregroundColor: Colors.white,
            backgroundColor: primary,
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.of(context).pushNamed(NewBudgetView.routeName);
            },
            child: const Icon(Icons.add, size: 32)
          ),
        ),
      ),
    );
  }
}
