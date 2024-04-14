import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/shared/bottom_sheet/bottom_sheet_body.dart';
import 'package:flutter_xspend/src/utils/color_util.dart';
import 'package:flutter_xspend/src/bloc/exchange_rate/exchange_rate_bloc.dart';

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
  final khrController = TextEditingController();
  final usdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadDefaultRate();
  }

  void loadDefaultRate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    khrController.text = prefs.getInt('KHR_RATE') != null ? prefs.getInt('KHR_RATE').toString() : '';
    usdController.text = prefs.getInt('USD_RATE') != null ? prefs.getInt('USD_RATE').toString() : '';
  }

  void saveInLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('KHR_RATE', int.parse(khrController.text));
    await prefs.setInt('USD_RATE', int.parse(usdController.text));
  }

  void save() {
    saveInLocal();
    Map<String, int> rate = { 'khr': int.parse(khrController.text), 'usd': int.parse(usdController.text)};
    context.read<ExchangeRateBloc>().add(UpdateExchangeRate(exchangeRate: rate));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Widget textField(String title, String hint, textController) {
    return Flexible(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextField(
            controller: textController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: pewter, fontSize: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: primary, width: 1.5),
              ),
              filled: false,
            ),
            style: const TextStyle(color: Colors.white),
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
          )
        ],
      ),
    );
  }

  Widget exchangeRateForm(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              textField('រៀល (KHR)', 'KHR rate', khrController),
              const Padding(
                padding: EdgeInsets.only(left: 12, right: 12, top: 24),
                child: Icon(Icons.compare_arrows_outlined, color: Colors.white,)
              ),
              textField('USD', 'USD rate', usdController),
            ],
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 22),
            child: FilledButton(
              onPressed: () { save(); },
              child: Text(AppLocalizations.of(context)!.save)
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
        title: AppLocalizations.of(context)!.exchangeRate,
        titleIcon: Icon(Icons.show_chart_rounded, color: getColorFromHex('#00f6ff'), size: 26),
        body: exchangeRateForm(context),
      ),
    );
  }
}