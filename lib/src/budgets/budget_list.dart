import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/constants/font_size.dart';
import 'package:flutter_xspend/src/localization/localization_service.dart';

class BudgetList extends StatefulWidget {
  const BudgetList({super.key});

  @override
  State<BudgetList> createState() => _BudgetListState();
}

class _BudgetListState extends State<BudgetList> {
  List budgets = [
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
    Widget listItem(index) {
      final budget = budgets[index];

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(budget['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
            const Text('\$50.00 left out of \$50.00 (\$0.00 spent)', style: TextStyle(color: primary, fontWeight: FontWeight.bold)),
            Text('You can spend \$25.00 each day for the rest of the period. (2 days left)', style: TextStyle(fontSize: xsFontSize, color: pewter)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LocalizationService.getTranslatedFullDate(budget['start_date'])),
                Text(LocalizationService.getTranslatedFullDate(budget['end_date'])),
              ],
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: budgets.length,
      itemBuilder: (context, index) {
        return listItem(index);
      }
    );
  }
}