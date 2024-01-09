import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/shared/bottom_sheet/bottom_sheet_body.dart';

class CurrencyTypePicker extends StatefulWidget {
  const CurrencyTypePicker({super.key});

  @override
  State<CurrencyTypePicker> createState() => _CurrencyTypePickerState();
}

class _CurrencyTypePickerState extends State<CurrencyTypePicker> {
  Widget currencyPicker() {
    final currencyTypes = [
      {'label': 'KHR', 'value': 0},
      {'label': 'USD', 'value': 1},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (int i = 0; i < currencyTypes.length; i++)
            Wrap(
              children: [
                InkWell(
                  onTap: () {print('asdfasdfasdfasdfasfd');},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(currencyTypes[i]['label'].toString())
                          )
                        ),
                      ),
                      const Icon(Icons.check, color: primary)
                    ],
                  ),
                ),
                if (i < currencyTypes.length - 1)
                  const Divider(color: grey, height: 0.2)
              ]
            ),
        ],
      ),
    );
  }

  void showCurrencyPicker() {
    Widget body = BottomSheetBody(
      title: 'Currency type',
      titleIcon: const Icon(Icons.payments_outlined, color: Colors.green),
      body: currencyPicker(),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        // heightFactor: 0.6,
        child: body,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { showCurrencyPicker(); },
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