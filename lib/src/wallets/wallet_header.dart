import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';

class WalletHeader extends StatelessWidget {
  const WalletHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Column(
          children: [
            Text('KHR Wallet screen',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: lightGreen)
            ),
            const Text('USD Wallet screen',
              style: TextStyle(
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