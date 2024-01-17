import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/shared/bottom_sheet/bottom_sheet_body.dart';
import 'package:flutter_xspend/src/utils/color_util.dart';

class ExchangeRateBottomSheet extends StatefulWidget {
  const ExchangeRateBottomSheet({super.key});

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => this,
    );
  }

  @override
  State<ExchangeRateBottomSheet> createState() => _ExchangeRateBottomSheetState();
}

class _ExchangeRateBottomSheetState extends State<ExchangeRateBottomSheet> {
  Widget exchangeRateForm(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text('KHR', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    TextField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: 'KHR rate',
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
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12, right: 12, top: 24),
                child: Icon(Icons.compare_arrows_outlined, color: Colors.white,)
              ),
              Flexible(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text('USD', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    TextField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: 'USD rate',
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
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 22),
            child: FilledButton(
              onPressed: () {},
              child: const Text('Save')
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: BottomSheetBody(
        title: 'Exchange rate',
        titleIcon: Icon(Icons.show_chart_rounded, color: getColorFromHex('#00f6ff'), size: 26),
        body: exchangeRateForm(context),
      ),
    );
  }
}