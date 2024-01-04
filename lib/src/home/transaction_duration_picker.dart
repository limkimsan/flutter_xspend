import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';

class TransactionDurationPicker extends StatefulWidget {
  const TransactionDurationPicker({super.key});

  @override
  State<TransactionDurationPicker> createState() => _TransactionDurationPickerState();
}

class _TransactionDurationPickerState extends State<TransactionDurationPicker> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
        alignment: Alignment.center,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primary,
        ),
        child: const Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Text('Month', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 24),
          ],
        ),
      ),
    );
  }
}