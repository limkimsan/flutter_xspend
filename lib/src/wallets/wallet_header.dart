import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:flutter_xspend/src/helpers/transaction_helper.dart';
import 'package:flutter_xspend/src/bloc/exchange_rate/exchange_rate_bloc.dart';

class WalletHeader extends StatefulWidget {
  const WalletHeader({super.key});

  @override
  State<WalletHeader> createState() => _WalletHeaderState();
}

class _WalletHeaderState extends State<WalletHeader> {
  String formattedKhr = '';
  String formattedUsd = '';
  String basedCurrency = 'khr';

  @override
  void initState() {
    super.initState();
    loadBalance();
  }

  void loadBalance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: use_build_context_synchronously
    final state = context.read<ExchangeRateBloc>().state;
    basedCurrency = prefs.getString('BASED_CURRENCY') ?? 'khr';
    List transactions = await Transaction.getAllOfCurrentUser();
    setState(() {
      formattedKhr = TransactionHelper.getFormattedTotal(transactions, state.exchangeRate, 'khr');
      formattedUsd = TransactionHelper.getFormattedTotal(transactions, state.exchangeRate, 'usd');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Column(
          children: [
            Text(basedCurrency == 'khr' ? formattedKhr : formattedUsd,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: lightGreen)
            ),
            Text(basedCurrency == 'khr' ? formattedUsd : formattedKhr,
              style: const TextStyle(
                color: grey,
                fontSize: 14,
                fontWeight: FontWeight.w700
              )
            ),
            const SizedBox(height: 12),
            const Text('Total Balance', style: TextStyle(color: pewter))
          ],
        ),
      ),
    );
  }
}