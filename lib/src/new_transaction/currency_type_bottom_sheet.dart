import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/shared/bottom_sheet/bottom_sheet_body.dart';
import 'package:flutter_xspend/src/constants/transaction_constant.dart';
import 'package:flutter_xspend/src/services/home_widget_service.dart';

class CurrencyTypeBottomSheet extends StatefulWidget {
  const CurrencyTypeBottomSheet(this.selectedCurrency, this.updateSelectedCurrency, {super.key});

  final String selectedCurrency;
  final void Function(String currency) updateSelectedCurrency;

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => this,
    );
  }

  @override
  State<CurrencyTypeBottomSheet> createState() => _CurrencyTypeBottomSheetState();
}

class _CurrencyTypeBottomSheetState extends State<CurrencyTypeBottomSheet> {
  Widget currencyPicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (int i = 0; i < currencyTypes.length; i++)
            Wrap(children: [
              InkWell(
                onTap: () {
                  widget.updateSelectedCurrency(currencyTypes[i]['value'].toString());
                  HomeWidgetService.updateCurrencyType(currencyTypes[i]['value'].toString());
                  HomeWidgetService.updateInfo();
                },
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
                    if (widget.selectedCurrency == currencyTypes[i]['value'])
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
    Widget body = BottomSheetBody(
      title: 'Currency type',
      titleIcon: const Icon(Icons.payments_outlined, color: Colors.green),
      body: currencyPicker(),
    );

    return FractionallySizedBox(
      // heightFactor: 0.6,
      child: body,
    );
  }
}