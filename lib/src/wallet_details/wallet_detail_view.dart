import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/wallet_details/wallet_detail_summary_header.dart';
import 'package:flutter_xspend/src/shared/transaction_duration_switcher/transaction_duration_switcher.dart';
import 'package:flutter_xspend/src/shared/transaction_list/transaction_list.dart';
import 'package:flutter_xspend/src/shared/transaction_list/transaction_list_total_expense.dart';

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
        title: Text(AppLocalizations.of(context)!.balanceDetail),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: WalletDetailSummaryHeader(selectedDate: selectedDate,),
            ),
            TransactionDurationSwitcher(selectedDate: selectedDate, updateSelectedDate: (date) {
              setState(() { selectedDate = date; });
            }),
            SizedBox(
              height: 84,
              child: TransactionListTotalExpense(selectedDate: selectedDate)
            ),
            const SizedBox(height: 12),
            const Expanded(
              child: TransactionList(hasLineChart: false, isSlideable: false),
            ),
          ],
        )
      ),
    );
  }
}