import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/constants/font_size.dart';
import 'package:flutter_xspend/src/localization/localization_service.dart';
import 'package:flutter_xspend/src/bloc/exchange_rate/exchange_rate_bloc.dart';
import 'package:flutter_xspend/src/models/budget.dart';
import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:flutter_xspend/src/utils/currency_util.dart';
import 'package:flutter_xspend/src/utils/math_util.dart';
import 'package:flutter_xspend/src/helpers/budget_helper.dart';
import 'package:flutter_xspend/src/bloc/budget/budget_bloc.dart';
import 'budget_calculation_service.dart';
import 'budget_empty_message.dart';

class BudgetList extends StatefulWidget {
  const BudgetList({super.key});

  @override
  State<BudgetList> createState() => _BudgetListState();
}

class _BudgetListState extends State<BudgetList> {
  List transactionList = [];

  @override
  void initState() {
    super.initState();
    BudgetHelper.loadBudgets((budgets) {
      context.read<BudgetBloc>().add(LoadBudget(budgets: budgets));
      loadTransactions(budgets);
    });
  }

  void loadTransactions(budgets) async {
    List tranList = [];
    for (Budget budget in budgets) {
      final transactions = await Transaction.getAllByDurationType('custom', budget.startDate.toString(), budget.endDate.toString());
      tranList.add(transactions);
    }
    setState(() {
      transactionList = tranList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ExchangeRateBloc>().state;
    final budgetState = context.watch<BudgetBloc>().state;

    Widget listItem(index) {
      final budget = budgetState.budgets[index];
      final budgetCal = BudgetCalculationService(budget, transactionList[index], state.exchangeRate);
      final Map<String, dynamic> progress = budgetCal.getProgress();

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(budget.name!,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: 16)),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                    CurrencyUtil.getCurrencyFormat(
                        progress['remainAmount'], budget.currencyType),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 14,
                        color: primary,
                        fontWeight: FontWeight.w900)),
                Text(
                    AppLocalizations.of(context)!.budgetSpendRecommendation(
                        CurrencyUtil.getCurrencyFormat(
                            budget.amount, budget.currencyType),
                        CurrencyUtil.getCurrencyFormat(
                            progress['expense'], budget.currencyType)),
                    style: const TextStyle(
                        color: primary, fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            RichText(
              text: TextSpan(
                text: AppLocalizations.of(context)!.youCanSpend,
                style: TextStyle(fontSize: xsFontSize, color: pewter),
                children: <TextSpan>[
                  TextSpan(
                    text: CurrencyUtil.getCurrencyFormat(
                        progress['amountEachDay'], budget.currencyType),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: xsFontSize,
                        color: pewter,
                        fontWeight: FontWeight.w900),
                  ),
                  TextSpan(
                      text: AppLocalizations.of(context)!
                          .eachDayForTheRestOfPeriod(
                              progress['remainingDays'])),
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
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
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
                Text(LocalizationService.getTranslatedFullDate(
                    budget.startDate)),
                Text(LocalizationService.getTranslatedFullDate(budget.endDate)),
              ],
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: const Divider(color: grey)),
          ],
        ),
      );
    }

    if (budgetState.budgets.isEmpty || transactionList.isEmpty) {
      return const BudgetEmptyMessage();
    }

    return BlocListener<BudgetBloc, BudgetState>(
      listener: (context, state) {
        loadTransactions(state.budgets);
      },
      child: ListView.builder(
        itemCount: budgetState.budgets.length,
        itemBuilder: (context, index) {
          return listItem(index);
        }
      ),
    );
  }
}
