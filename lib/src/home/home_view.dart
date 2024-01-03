import 'package:flutter/material.dart';

import 'home_header.dart';
import 'home_transaction_duration.dart';
import 'transaction_list.dart';
import 'package:flutter_xspend/src/constants/colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeHeader(),
        const HomeTransactionDuration(),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(right: 16, top: 16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Total expense', style: TextStyle(color: grey)),
                Text('- KHR 0', style: TextStyle(color: red)),
                Text('- \$ 0', style: TextStyle(color: red)),
              ],
            ),
          ),
        ),
        const TransactionList(),
      ],
    );
  }
}