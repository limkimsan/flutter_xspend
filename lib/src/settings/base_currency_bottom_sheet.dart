import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/shared/bottom_sheet/bottom_sheet_body.dart';
import 'package:flutter_xspend/src/constants/transaction_constant.dart';
import 'package:flutter_xspend/src/bloc/base_currency/base_currency_bloc.dart';
import 'package:flutter_xspend/src/services/home_widget_service.dart';

class BaseCurrencyBottomSheet extends StatefulWidget {
  const BaseCurrencyBottomSheet({super.key});

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
  void updateBaseCurrencyBloc(selectedCurrency) {
    context.read<BaseCurrencyBloc>().add(UpdateBaseCurrency(currency: selectedCurrency));
  }

  Widget currencyPicker(ctx) {
    final state = context.watch<BaseCurrencyBloc>().state;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (int i = 0; i < currencyTypes.length; i++)
            Wrap(children: [
              InkWell(
                onTap: () async {
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setString('BASED_CURRENCY', currencyTypes[i]['value'].toString());
                  updateBaseCurrencyBloc(currencyTypes[i]['value']);
                  HomeWidgetService.updateCurrencyType(currencyTypes[i]['value'].toString());
                  HomeWidgetService.updateInfo();
                  Navigator.of(ctx).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: 48,
                        width: double.infinity,
                        child: Align(alignment: Alignment.centerLeft, child: Text(currencyTypes[i]['label'].toString()))
                      ),
                    ),
                    // if (widget.basedCurrency == currencyTypes[i])
                    if (state.currency == currencyTypes[i]['value'])
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
        title: AppLocalizations.of(context)!.baseCurrency,
        titleIcon: const Icon(Icons.currency_exchange_outlined, color: lightGreen, size: 26),
        body: currencyPicker(context),
      ),
    );
  }
}