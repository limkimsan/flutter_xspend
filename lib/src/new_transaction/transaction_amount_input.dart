import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/utils/currency_util.dart';

class TransactionAmountInput extends StatelessWidget {
  const TransactionAmountInput({super.key, required this.controller, required this.onChange});

  final TextEditingController controller;
  final Function(String value) onChange;

  void onAmountChange(value) {
    if (value.isNotEmpty && !value.contains('.')) {
      String newText = CurrencyUtil.formatNumber(value.replaceAll(' ', ''));
      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
    onChange(controller.text.replaceAll(' ', ''));
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (value) => onAmountChange(value),
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.transactionAmount,
            hintStyle: const TextStyle(color: pewter, fontSize: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: primary, width: 1.5),
            ),
            filled: false,
          ),
          style: const TextStyle(color: pewter),
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }
}