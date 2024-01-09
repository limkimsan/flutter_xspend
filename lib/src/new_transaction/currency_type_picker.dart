import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';

class CurrencyTypePicker extends StatefulWidget {
  const CurrencyTypePicker({super.key});

  @override
  State<CurrencyTypePicker> createState() => _CurrencyTypePickerState();
}

class _CurrencyTypePickerState extends State<CurrencyTypePicker> {
  Widget currencyPicker() {
    return Container(
      decoration: const BoxDecoration(
        color: bottomSheetBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
    );
  }

  void showCurrencyPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.6,
        child: currencyPicker(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 5),
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primary,
        ),
        child: const Row(
          children: [
            Text('KHR'),
            Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white)
          ],
        ),
      ),
    );
  }
}