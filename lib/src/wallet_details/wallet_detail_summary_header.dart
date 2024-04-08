import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xspend/src/bloc/exchange_rate/exchange_rate_bloc.dart';
import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/constants/font_size.dart';
import 'package:flutter_xspend/src/bloc/transaction/transaction_bloc.dart';
import 'package:flutter_xspend/src/bloc/transaction/transaction_state.dart';
import 'package:flutter_xspend/src/helpers/transaction_helper.dart';

class WalletDetailSummaryHeader extends StatefulWidget {
  const WalletDetailSummaryHeader({super.key, required this.selectedDate});

  final DateTime selectedDate;

  @override
  State<WalletDetailSummaryHeader> createState() => _WalletDetailSummaryHeaderState();
}

class _WalletDetailSummaryHeaderState extends State<WalletDetailSummaryHeader> {
  String khrBalance = '';
  String usdBalance = '';
  String khrCashflow = '';
  String usdCashflow = '';
  String basedCurrency = 'khr';
  bool isNegative = false;

  @override
  void initState() {
    super.initState();
    loadBalance();
    loadCashflow();
  }

  @override
  void didUpdateWidget(covariant WalletDetailSummaryHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate) {
      loadCashflow(widget.selectedDate);
    }
  }

  void loadBalance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: use_build_context_synchronously
    final state = context.read<ExchangeRateBloc>().state;
    basedCurrency = prefs.getString('BASED_CURRENCY') ?? 'khr';
    List<Transaction> transactions = await Transaction.getAllOfCurrentUser();
    setState(() {
      khrBalance = TransactionHelper.getFormattedTotal(transactions, state.exchangeRate, 'khr');
      usdBalance = TransactionHelper.getFormattedTotal(transactions, state.exchangeRate, 'usd');
    });
  }

  void loadCashflow([selectedDate]) async {
    List<Transaction> transactions = selectedDate != null ? await Transaction.getAllByMonth(widget.selectedDate) : [];
    TransactionHelper(transactions: transactions).calculateTransactionsGrandTotal((result) {
      setState(() {
        isNegative = result['income']['usd'] - result['expense']['usd'] < 0 ? true : false;
        usdCashflow = TransactionHelper.getCalculatedAmountForDisplay('usd', result['income']['usd'], result['expense']['usd']);
        khrCashflow = TransactionHelper.getCalculatedAmountForDisplay('khr', result['income']['khr'], result['expense']['khr']);
      });
    });
  }

  Widget summaryLabel(title, khrValue, usdValue, [hasNegative = false]) {
    Color mainLabelColor = (hasNegative && isNegative) ? red : lightGreen;
    Color subLabelColor = (hasNegative && isNegative) ? red : pewter;

    return Column(
      children: [
        Text(title, style: const TextStyle(color: pewter)),
        Text(basedCurrency == 'khr' ? khrValue : usdValue, style: TextStyle(color: mainLabelColor, fontWeight: FontWeight.bold, fontSize: mdHeader)),
        Text(basedCurrency == 'khr' ? usdValue : khrValue, style: TextStyle(color: subLabelColor, fontSize: smHeader)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        loadCashflow();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          summaryLabel('Wallet Balance', khrBalance, usdBalance),
          Container(
            width: 0.5,
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 0.5
              )
            ),
            child: const SizedBox(
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          summaryLabel('Cashflow', khrCashflow, usdCashflow, true),
        ],
      ),
    );
  }
}