import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'new_budget_form.dart';

class NewBudgetView extends StatelessWidget {
  const NewBudgetView({super.key});

  static const routeName = '/new_budget';

  @override
  Widget build(BuildContext context) {
    String? budgetId;
    if (ModalRoute.of(context)?.settings.arguments != null) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      budgetId = args['budgetId'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(budgetId == null ? AppLocalizations.of(context)!.createNewBudget : AppLocalizations.of(context)!.editBudget),
      ),
      body: SafeArea(child: NewBudgetForm(budgetId: budgetId)),
    );
  }
}