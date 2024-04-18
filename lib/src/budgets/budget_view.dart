import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/localization/localization_service.dart';
import 'package:flutter_xspend/src/constants/colors.dart';
import 'budget_empty_message.dart';

class BudgetView extends StatefulWidget {
  const BudgetView({super.key});

  @override
  State<BudgetView> createState() => _BudgetViewState();
}

class _BudgetViewState extends State<BudgetView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context)!.budget)
      ),
      body: const BudgetEmptyMessage(),
      floatingActionButton: SizedBox(
        height: 56,
        width: 56,
        child: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: primary,
          shape: const CircleBorder(),
          onPressed: () {},
          child: const Icon(Icons.add, size: 32)
        )
      )
    );
  }
}