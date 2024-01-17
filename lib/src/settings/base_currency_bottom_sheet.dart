import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/shared/bottom_sheet/bottom_sheet_body.dart';
import 'package:flutter_xspend/src/constants/transaction_constant.dart';

class BaseCurrencyBottomSheet extends StatefulWidget {
  const BaseCurrencyBottomSheet({super.key, required this.basedCurrency, required this.updateBasedCurrency});

  final String basedCurrency;
  final void Function(String currency) updateBasedCurrency;

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => this,
    );
  }

  @override
  State<BaseCurrencyBottomSheet> createState() => _BaseCurrencyBottomSheetState();
}

class _BaseCurrencyBottomSheetState extends State<BaseCurrencyBottomSheet> {
  Widget currencyPicker(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (int i = 0; i < currencyTypes.length; i++)
            Wrap(children: [
              InkWell(
                onTap: () async {
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('BASED_CURRENCY', currencyTypes[i]);
                  widget.updateBasedCurrency(currencyTypes[i]);
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: Align(alignment: Alignment.centerLeft, child: Text(currencyTypes[i].toUpperCase()))
                      ),
                    ),
                    if (widget.basedCurrency == currencyTypes[i])
                      const Icon(Icons.check, color: primary)
                  ],
                ),
              ),
              if (i < currencyTypes.length - 1)
                const Divider(color: grey, height: 0.2)
            ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      // heightFactor: 0.6,
      child: BottomSheetBody(
        title: 'Base currency',
        titleIcon: const Icon(Icons.currency_exchange_outlined, color: lightGreen, size: 26),
        body: currencyPicker(context),
      ),
    );
  }
}