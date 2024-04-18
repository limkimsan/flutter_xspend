import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
            Text(budget['name'], style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
            const SizedBox(height: 8,),
            Row(
              children: [
                Text('\$50.00', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 14, color: primary, fontWeight: FontWeight.w900)),
                const Text(' left out of \$50.00 (\$0.00 spent)', style: TextStyle(color: primary, fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(height: 4,),
            RichText(
              text: TextSpan(
                text: 'You can spend ',
                style: TextStyle(fontSize: xsFontSize, color: pewter),
                children: <TextSpan>[
                  TextSpan(
                    text: '\$25.00',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: xsFontSize, color: pewter, fontWeight: FontWeight.w900),
                  ),
                  const TextSpan(text: ' each day for the rest of the period. (2 days left)'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearPercentIndicator(
                  lineHeight: 24,
                  percent: 0.5,
                  center: const Text("100%", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  progressColor: Colors.green,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                ),
              ),
            ),
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