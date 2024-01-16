import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'currency_type_bottom_sheet.dart';

class CurrencyTypePicker extends StatelessWidget {
  const CurrencyTypePicker(this.selectedCurrency, this.updateSelectedCurrency, {super.key});

  final String selectedCurrency;
  final void Function(String currency) updateSelectedCurrency;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CurrencyTypeBottomSheet(selectedCurrency, updateSelectedCurrency).showBottomSheet(context);
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 5),
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primary,
        ),
        child: Row(
          children: [
            Text(selectedCurrency),
            const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white)
          ],
        ),
      ),
    );
  }
}