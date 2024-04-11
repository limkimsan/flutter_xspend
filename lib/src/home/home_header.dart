import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/helpers/transaction_helper.dart';
import 'package:flutter_xspend/src/bloc/transaction/transaction_bloc.dart';
import 'package:flutter_xspend/src/bloc/transaction/transaction_state.dart';
import 'package:flutter_xspend/src/models/transaction.dart';
// import 'package:flutter_xspend/src/localization/localization_service.dart';
// import 'package:flutter_xspend/src/localization/main_localization.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key, required this.selectedDate});
  final DateTime selectedDate;

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String mainTitle = '';
  String subtitle = '';
  bool isNegative = false;

  @override
  void initState() {
    super.initState();
    loadTotal();
  }
  
  @override
  void didUpdateWidget(covariant HomeHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate) {
      loadTotal(widget.selectedDate);
    }
  }

  void loadTotal([selectedDate]) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Transaction> transactions = selectedDate != null ? await Transaction.getAllByMonth(widget.selectedDate) : [];
    TransactionHelper(transactions: transactions).calculateTransactionsGrandTotal((result) {
      setState(() {
        isNegative = result['income']['usd'] - result['expense']['usd'] < 0 ? true : false;
        if (prefs.getString('BASED_CURRENCY') == 'usd') {
          mainTitle = TransactionHelper.getCalculatedAmountForDisplay('usd', result['income']['usd'], result['expense']['usd']);
          subtitle = TransactionHelper.getCalculatedAmountForDisplay('khr', result['income']['khr'], result['expense']['khr']);
        }
        else {
          mainTitle = TransactionHelper.getCalculatedAmountForDisplay('khr', result['income']['khr'], result['expense']['khr']);
          subtitle = TransactionHelper.getCalculatedAmountForDisplay('usd', result['income']['usd'], result['expense']['usd']);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        // Perform actions based on transaction state (bloc) changes
        loadTotal();
      },
      child: Center(
        child: SafeArea(
          child: Column(
            children: [
              Text(
                // LocalizationService.translate(context, 'helloWorld'),
                // AppLocalizations.of(context)!.hello('Jonh'),
                mainTitle,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: isNegative ? red : yellow
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(color: isNegative ? red : lightGreen, fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      )
    );
  }
}