import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/utils/currency_util.dart';

class CurrencyTextField extends StatelessWidget {
  const CurrencyTextField({super.key, required this.hintText, required this.controller, required this.onChanged, this.validator});

  final String hintText;
  final TextEditingController controller;
  final Function(String value) onChanged;
  final Function(String? value)? validator;

  void onAmountChange(value) {
    if (value.isNotEmpty && !value.contains('.')) {
      String newText = CurrencyUtil.formatNumber(value.replaceAll(' ', ''));
      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
    onChanged(controller.text.replaceAll(' ', ''));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        hintText: hintText,
      ),
      onChanged: (value) => onAmountChange(value),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      validator: (value) {
        if (validator != null) {
          String? newValue = value;
          if (value != '') {
            newValue = value!.replaceAll(' ', '');
          }
          validator?.call(newValue);
        }
        return null;
      },
    );
  }
}

// TextFormField(
//   controller: _nameController,
//   decoration: InputDecoration(
//     hintText: AppLocalizations.of(context)!.pleaseEnterBudgetName,
//   ),
//   validator: (value) {
//     if (value == null || value.isEmpty) {
//       return AppLocalizations.of(context)!.budgetNameIsRequired;
//     }
//     return null;
//   },
//   onSaved: (value) { name = value; },
//   onChanged: (value) {
//     name = value;
//     setState(() {
//       isValid = BudgetController.isValidForm(value, amount, startDate, endDate);
//     });
//   },
//   onTapOutside: (event) {
//     FocusScope.of(context).unfocus();
//   },
// ),