import 'package:flutter/material.dart';

import 'home_header.dart';
import 'home_transaction_duration.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HomeHeader(),
        HomeTransactionDuration(),
      ],
    );
  }
}