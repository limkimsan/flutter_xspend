import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/home/home_view.dart';
// import 'package:flutter_xspend/src/constants/colors.dart';

class BottomTabView extends StatefulWidget {
  const BottomTabView({super.key});

  static const routeName = '/bottom_tab';

  @override
  State<BottomTabView> createState() => _BottomTabViewState();
}

class _BottomTabViewState extends State<BottomTabView> {
  int _selectedIndex = 0;

  selectPage(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomeView();

    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) { selectPage(index); },
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: 'Timeline'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Budget'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ]
      ),
    );
  }
}