import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/wallets/wallet_header.dart';
import 'package:flutter_xspend/src/wallets/wallet_line_chart.dart';
import 'package:flutter_xspend/src/wallet_details/wallet_detail_view.dart';
import 'package:flutter_xspend/src/bloc/budget/budget_bloc.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key, required this.budgetBloc});

  final BudgetBloc budgetBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: budgetBloc,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 120,
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: background),
            child: const WalletHeader(),
          ),
        ),
        body: Column(
          children: [
            const WalletLineChart(),
            const SizedBox(height: 46),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(WalletDetailView.routeName);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.viewBalanceDetail,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: primary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
