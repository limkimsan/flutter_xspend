import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/new_transaction/transaction_controller.dart';
import 'package:flutter_xspend/src/helpers/transaction_helper.dart';
import 'package:flutter_xspend/src/bloc/transaction/transaction_bloc.dart';
import 'package:flutter_xspend/src/bloc/transaction/transaction_state.dart';
import 'package:flutter_xspend/src/models/transaction.dart';

class HomeTotalExpense extends StatefulWidget {
  const HomeTotalExpense({super.key, required this.selectedDate});
  final DateTime selectedDate;

  @override
  State<HomeTotalExpense> createState() => _HomeTotalExpenseState();
}

class _HomeTotalExpenseState extends State<HomeTotalExpense> {
  String basedCurrency = 'khr';
  String mainTitle = '';
  String subtitle = '';

  @override
  void initState() {
    super.initState();
    loadTotal();
  }

  @override
  void didUpdateWidget(covariant HomeTotalExpense oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate) {
      loadTotal(widget.selectedDate);
    }
  }

  void loadTotal([selectedDate]) async {
    List? transactions;
    if (selectedDate != null) {
      DateTime startOfNextMonth = DateTime(widget.selectedDate.year, widget.selectedDate.month + 1, 1);
      transactions = await Transaction.getAllByDurationType(
                              'custom',
                              DateTime(widget.selectedDate.year, widget.selectedDate.month, 1).toString(),
                              startOfNextMonth.subtract(const Duration(days: 1)).toString()
                            );
    }

    TransactionController.calculateGrandTotal((result) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        if (prefs.getString('BASED_CURRENCY') == 'usd') {
          mainTitle = TransactionHelper.getCalculatedAmountForDisplay('usd', result['expense']['usd'], 0);
          subtitle = TransactionHelper.getCalculatedAmountForDisplay('khr', result['expense']['khr'], 0);
        }
        else {
          mainTitle = TransactionHelper.getCalculatedAmountForDisplay('khr', result['expense']['khr'], 0);
          subtitle = TransactionHelper.getCalculatedAmountForDisplay('usd', result['expense']['usd'], 0);
        }
        basedCurrency = prefs.getString('BASED_CURRENCY') ?? 'khr';
      });
    }, transactions);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        loadTotal();
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.only(bottom: 0, right: 16, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('Total expense', style: TextStyle(color: grey)),
              Text('- $mainTitle', style: const TextStyle(color: red)),
              Text('- $subtitle', style: const TextStyle(color: red)),
            ],
          ),
        ),
      )
    );
  }
}