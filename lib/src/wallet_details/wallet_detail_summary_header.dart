import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xspend/src/bloc/exchange_rate/exchange_rate_bloc.dart';
import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/constants/font_size.dart';
import 'package:flutter_xspend/src/bloc/exchange_rate/exchange_rate_bloc.dart';
import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:flutter_xspend/src/helpers/transaction_helper.dart';

class WalletDetailSummaryHeader extends StatefulWidget {
  const WalletDetailSummaryHeader({super.key});

  @override
  State<WalletDetailSummaryHeader> createState() => _WalletDetailSummaryHeaderState();
}

class _WalletDetailSummaryHeaderState extends State<WalletDetailSummaryHeader> {
  String khrBalance = '';
  String usdBalance = '';
  String khrCashflow = '';
  String usdCashflow = '';
  String basedCurrency = 'khr';

  @override
  void initState() {
    super.initState();
    loadBalanceAndCashflow();
  }

  void loadBalanceAndCashflow() async {
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

  Widget summaryLabel(title, khrValue, usdValue) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: pewter)),
        Text(basedCurrency == 'khr' ? khrValue : usdValue, style: TextStyle(color: lightGreen, fontWeight: FontWeight.bold, fontSize: mdHeader)),
        Text(basedCurrency == 'khr' ? usdValue : khrValue, style: TextStyle(color: pewter, fontSize: smHeader)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
        summaryLabel('Monthly Cashflow', 'KHR 10000000000', '100000000'),
      ],
    );
  }
}