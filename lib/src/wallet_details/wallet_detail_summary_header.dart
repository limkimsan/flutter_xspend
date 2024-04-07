import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/constants/font_size.dart';

class WalletDetailSummaryHeader extends StatefulWidget {
  const WalletDetailSummaryHeader({super.key});

  @override
  State<WalletDetailSummaryHeader> createState() => _WalletDetailSummaryHeaderState();
}

class _WalletDetailSummaryHeaderState extends State<WalletDetailSummaryHeader> {
  Widget summaryLabel(title, khrValue, usdValue) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: pewter)),
        Text(khrValue, style: TextStyle(color: lightGreen, fontWeight: FontWeight.bold, fontSize: mdHeader)),
        Text(usdValue, style: TextStyle(color: pewter, fontSize: smHeader)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        summaryLabel('Wallet Balance', 'KHR 1000000000', '1000000'),
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