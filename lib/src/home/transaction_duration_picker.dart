import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'transaction_duration_bottom_sheet.dart';
import 'package:flutter_xspend/src/utils/string_util.dart';

class TransactionDurationPicker extends StatefulWidget {
  const TransactionDurationPicker({super.key});

  @override
  State<TransactionDurationPicker> createState() => _TransactionDurationPickerState();
}

class _TransactionDurationPickerState extends State<TransactionDurationPicker> {
  String selectedDuration = 'month';

  void onDurationChanged(duration) {
    setState(() {
      selectedDuration = duration;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        TransactionDurationBottomSheet(
          selectedDuration: selectedDuration,
          updateSelectedDuration: onDurationChanged
        ).showBottomSheet(context);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
        alignment: Alignment.center,
        height: 48,
        width: 115,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primary,
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(StringUtil.capitalize(selectedDuration), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 24),
          ],
        ),
      ),
    );
  }
}