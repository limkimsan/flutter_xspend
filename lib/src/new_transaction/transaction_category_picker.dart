import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'transaction_category_bottom_sheet.dart';

class TransactionCategoryPicker extends StatelessWidget {
  const TransactionCategoryPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        const TransactionCategoryBottomSheet().showBottomSheet(context);
      },
      borderRadius: BorderRadius.circular(64),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(64),
        padding: const EdgeInsets.all(6),
        dashPattern: const [8],
        strokeWidth: 2.5,
        color: primary,
        child: const SizedBox(
          height: 64,
          width: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Select', style: TextStyle(color: primary, fontSize: 12)),
              Text('Category', style: TextStyle(color: primary, fontSize: 12))
            ],
          )
        ),
      ),
    );
  }
}