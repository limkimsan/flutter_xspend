import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'transaction_duration_picker.dart';

class HomeTransactionDuration extends StatefulWidget {
  const HomeTransactionDuration({super.key});

  @override
  State<HomeTransactionDuration> createState() => _HomeTransactionDurationState();
}

class _HomeTransactionDurationState extends State<HomeTransactionDuration> {
  String? label;

  @override
  void initState() {
    super.initState();
    loadPrefixLabel();
  }

  void loadPrefixLabel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    setState(() {
      if (prefs.getString('TRANSACTION_DURATION') == 'year') {
        label = now.year.toString();
      } else if (prefs.getString('TRANSACTION_DURATION') == 'custom') {
        label = 'Custom';
      }
      else {
        label = DateFormat('MMMM').format(now);
      }
    });
  }

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
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 4),
            child: Text(
              '$label cash flow',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: monthSwitcherBtn('23 Oct', true),
              ),
              TransactionDurationPicker(onDurationChanged: () { loadPrefixLabel(); },),
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