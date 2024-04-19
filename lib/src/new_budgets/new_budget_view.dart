import 'package:flutter/material.dart';

import 'new_budget_form.dart';

class NewBudgetView extends StatelessWidget {
  const NewBudgetView({super.key});

  static const routeName = '/new_budget';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Budget'),
      ),
      body: const SafeArea(child: NewBudgetForm()),
    );
  }
}