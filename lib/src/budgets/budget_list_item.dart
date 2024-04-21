import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/constants/font_size.dart';
import 'package:flutter_xspend/src/utils/currency_util.dart';
import 'package:flutter_xspend/src/utils/math_util.dart';
import 'package:flutter_xspend/src/models/budget.dart';
import 'package:flutter_xspend/src/localization/localization_service.dart';

class BudgetListItem extends StatelessWidget {
  const BudgetListItem({super.key, required this.budget, required this.progress});

  final Budget budget;
  final Map<String, dynamic> progress;

  @override
  Widget build(BuildContext context) {
    Widget listItem() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(budget.name!, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  CurrencyUtil.getCurrencyFormat(progress['remainAmount'], budget.currencyType),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 14,
                    color: primary,
                    fontWeight: FontWeight.w900)
                  ),
                Text(
                  AppLocalizations.of(context)!.budgetSpendRecommendation(
                    CurrencyUtil.getCurrencyFormat(budget.amount, budget.currencyType),
                    CurrencyUtil.getCurrencyFormat(progress['expense'], budget.currencyType)
                  ),
                  style: const TextStyle(color: primary, fontWeight: FontWeight.w900)
                ),
              ],
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                text: AppLocalizations.of(context)!.youCanSpend,
                style: TextStyle(fontSize: xsFontSize, color: pewter),
                children: <TextSpan>[
                  TextSpan(
                    text: CurrencyUtil.getCurrencyFormat(progress['amountEachDay'], budget.currencyType),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: xsFontSize,
                      color: pewter,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                  TextSpan(text: AppLocalizations.of(context)!.eachDayForTheRestOfPeriod(progress['remainingDays'])),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearPercentIndicator(
                  lineHeight: 24,
                  percent: progress['percentage'],
                  center: Text(
                    MathUtil.getFormattedPercentage(progress['percentage']),
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
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
          ],
        ),
      );
    }

    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: lightBlue,
            foregroundColor: Colors.white,
            icon: Icons.edit_outlined,
            label: AppLocalizations.of(context)!.edit
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: red,
            foregroundColor: Colors.white,
            icon: Icons.delete_outlined,
            label: AppLocalizations.of(context)!.delete
          )
        ],
      ),
      child: listItem(),
    );
  }
}