import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'transaction_duration_picker.dart';

class HomeTransactionDuration extends StatefulWidget {
  const HomeTransactionDuration({super.key});

  @override
  State<HomeTransactionDuration> createState() => _HomeTransactionDurationState();
}

class _HomeTransactionDurationState extends State<HomeTransactionDuration> {
  @override
  Widget build(BuildContext context) {

    Widget monthSwitcherBtn(label, isBackward) {
      return Container(
        padding: EdgeInsets.fromLTRB(isBackward ? 0 : 12, 0, isBackward ? 12 : 0, 0),
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(width: 2.5, color: primary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            if (isBackward)
              const Icon(Icons.chevron_left, color: primary, size: 28),
            Text(
              label,
              style: const TextStyle(color: primary, fontWeight: FontWeight.bold),
            ),
            if (!isBackward)
              const Icon(Icons.chevron_right, color: primary, size: 28),
          ],
        ),
      );
    }

    return Container(
      // padding: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16, top: 4),
            child: Text(
              'October cash flow',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: monthSwitcherBtn('23 Oct', true),
              ),
              const TransactionDurationPicker(),
              InkWell(
                child: monthSwitcherBtn('23 Nov', false)
              ),
            ],
          ),
        ],
      ),
    );
  }
}