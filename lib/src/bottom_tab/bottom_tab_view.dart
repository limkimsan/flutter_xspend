import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/home/home_view.dart';
import 'package:flutter_xspend/src/wallets/wallet_view.dart';
import 'package:flutter_xspend/src/budgets/budget_view.dart';
import 'package:flutter_xspend/src/settings/setting_view.dart';
import 'package:flutter_xspend/src/bloc/transaction/transaction_bloc.dart';
import 'package:flutter_xspend/src/bloc/budget/budget_bloc.dart';

class BottomTabView extends StatefulWidget {
  const BottomTabView({super.key, required this.transactionBloc});

  final TransactionBloc transactionBloc;

  static const routeName = '/bottom_tab';

  @override
  State<BottomTabView> createState() => _BottomTabViewState();
}

class _BottomTabViewState extends State<BottomTabView> {
  int _selectedIndex = 0;
  BudgetBloc budgetBloc = BudgetBloc();

  selectPage(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = HomeView(transactionBloc: widget.transactionBloc,);
    if (_selectedIndex == 1) {
      activePage = WalletView(budgetBloc: budgetBloc);
    }

    if (_selectedIndex == 2) {
      activePage = const BudgetView();
    }

    if (_selectedIndex == 3) {
      activePage = const SettingView();
    }

    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) { selectPage(index); },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.analytics_outlined), label: AppLocalizations.of(context)!.transaction),
          BottomNavigationBarItem(icon: const Icon(Icons.account_balance_wallet_outlined), label: AppLocalizations.of(context)!.wallet),
          BottomNavigationBarItem(icon: const Icon(Icons.assignment_outlined), label: AppLocalizations.of(context)!.budget),
          BottomNavigationBarItem(icon: const Icon(Icons.settings_outlined), label: AppLocalizations.of(context)!.settings),
        ]
      ),
    );
  }
}