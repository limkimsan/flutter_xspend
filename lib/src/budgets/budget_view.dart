import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'budget_empty_message.dart';
import 'budget_list.dart';
import 'package:flutter_xspend/src/new_budgets/new_budget_view.dart';

class BudgetView extends StatefulWidget {
  const BudgetView({super.key});

  @override
  State<BudgetView> createState() => _BudgetViewState();
}

class _BudgetViewState extends State<BudgetView> {
  static List budgets = [
    {
      'id': 'asdad1231',
      'name': 'Trip budget',
      'amount': '300',
      'start_date': DateTime.now(),
      'end_date': DateTime.now(),
      'currency_type': 'usd',
      'local_user_id': '123'
    }
  ];

  @override
  Widget build(BuildContext context) {
    Widget bodyWidget = const BudgetEmptyMessage();

    if (budgets.isNotEmpty) {
      bodyWidget = const BudgetList();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context)!.budget)
      ),
      // body: const BudgetEmptyMessage(),
      body: bodyWidget,
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
        )
      )
    );
  }
}