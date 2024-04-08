import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/wallet_details/wallet_detail_summary_header.dart';
import 'package:flutter_xspend/src/shared/transaction_duration_switcher/transaction_duration_switcher.dart';

class WalletDetailView extends StatefulWidget {
  const WalletDetailView({super.key});

  static const routeName = '/wallet_detail';

  @override
  State<WalletDetailView> createState() => _WalletDetailViewState();
}

class _WalletDetailViewState extends State<WalletDetailView> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Balance Detail')
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: WalletDetailSummaryHeader(),
            ),
            TransactionDurationSwitcher(selectedDate: selectedDate, updateSelectedDate: (date) {
              setState(() { selectedDate = date; });
            },),
          ],
        ),
      ),
    );
  }
}