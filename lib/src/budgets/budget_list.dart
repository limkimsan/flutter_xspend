import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/constants/font_size.dart';
import 'package:flutter_xspend/src/localization/localization_service.dart';
import 'package:flutter_xspend/src/models/budget.dart';

class BudgetList extends StatefulWidget {
  const BudgetList({super.key});

  @override
  State<BudgetList> createState() => _BudgetListState();
}

class _BudgetListState extends State<BudgetList> {
  List budgets = [];

  @override
  void initState() {
    super.initState();
    loadBudgets();
  }

  void loadBudgets() async {
    List result = await Budget.getAllOfCurrentUser();
    setState(() {
      budgets = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget listItem(index) {
      final budget = budgets[index];
      // print('=== budgets ====');
      // print(budget.toString());

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(budget.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
            const SizedBox(height: 8,),
            Row(
              children: [
                Text('\$50.00', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 14, color: primary, fontWeight: FontWeight.w900)),
                Text(AppLocalizations.of(context)!.budgetSpendRecommendation('\$100', '\$50'), style: const TextStyle(color: primary, fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(height: 4,),
            RichText(
              text: TextSpan(
                text: AppLocalizations.of(context)!.youCanSpend,
                style: TextStyle(fontSize: xsFontSize, color: pewter),
                children: <TextSpan>[
                  TextSpan(
                    text: '\$25.00',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: xsFontSize, color: pewter, fontWeight: FontWeight.w900),
                  ),
                  TextSpan(text: AppLocalizations.of(context)!.eachDayForTheRestOfPeriod(2)),
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
                Text(LocalizationService.getTranslatedFullDate(budget.startDate)),
                Text(LocalizationService.getTranslatedFullDate(budget.endDate)),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: const Divider(color: grey)
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