import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';

class TransactionCategoryPicker extends StatefulWidget {
  const TransactionCategoryPicker({super.key});

  @override
  State<TransactionCategoryPicker> createState() => _TransactionCategoryPickerState();
}

class _TransactionCategoryPickerState extends State<TransactionCategoryPicker> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 92,
        width: 92,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, style: BorderStyle.solid, color: primary),
          borderRadius: BorderRadius.circular(92),
        ),
        child: const Text('Select Category', style: TextStyle(color: primary)),
      ),
    );
  }
}