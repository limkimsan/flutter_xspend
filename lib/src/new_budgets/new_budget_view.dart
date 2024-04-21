import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'new_budget_form.dart';

class NewBudgetView extends StatelessWidget {
  const NewBudgetView({super.key});

  static const routeName = '/new_budget';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.createNewBudget),
      ),
      body: const SafeArea(child: NewBudgetForm()),
    );
  }
}