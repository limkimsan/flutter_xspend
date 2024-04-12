import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'transaction_duration_picker.dart';
import 'transaction_duration_controller.dart';
import 'package:flutter_xspend/src/utils/datetime_util.dart';
import 'package:flutter_xspend/src/bloc/transaction/transaction_bloc.dart';
import 'package:flutter_xspend/src/localization/localization_service.dart';

class TransactionDurationSwitcher extends StatefulWidget {
  const TransactionDurationSwitcher({super.key, required this.selectedDate, required this.updateSelectedDate});
  final DateTime selectedDate;
  final void Function(DateTime date) updateSelectedDate;

  @override
  State<TransactionDurationSwitcher> createState() => _TransactionDurationSwitcherState();
}

class _TransactionDurationSwitcherState extends State<TransactionDurationSwitcher> {
  String? label;
  String durationType = 'month';

  @override
  void initState() {
    super.initState();
    loadPrefixLabel();
  }

  void loadPrefixLabel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    setState(() {
      if (prefs.getString('TRANSACTION_DURATION') != null) {
        durationType = prefs.getString('TRANSACTION_DURATION').toString();
      }

      if (prefs.getString('TRANSACTION_DURATION') == 'year') {
        String placeholder = '${LocalizationService.currentLanguage == 'km' ? AppLocalizations.of(context)!.year : ''}${now.year.toString()}';
        label = AppLocalizations.of(context)!.cashflowTitle(placeholder);
      } else if (prefs.getString('TRANSACTION_DURATION') == 'custom') {
        label = AppLocalizations.of(context)!.cashflowTitle('');
      } else if (prefs.getString('TRANSACTION_DURATION') == 'week') {
        String placeholder = '${LocalizationService.currentLanguage == 'km' ? AppLocalizations.of(context)!.inThe : ''}${AppLocalizations.of(context)!.week}';
        label = AppLocalizations.of(context)!.cashflowTitle(placeholder);
      }
       else {
        String placeholder = '${LocalizationService.currentLanguage == 'km' ? AppLocalizations.of(context)!.month : ''}${LocalizationService.getTranslatedMonth(DateTime.now())}';
        label = AppLocalizations.of(context)!.cashflowTitle(placeholder);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget monthSwitcherBtn(label, isBackward) {
      if (durationType != 'month' || (!isBackward && !DateTimeUtil.ableMoveNextMonth(widget.selectedDate))) {
        return const SizedBox(width: 98);
      }

      return Container(
        padding: EdgeInsets.fromLTRB(isBackward ? 0 : 12, 0, isBackward ? 12 : 0, 0),
        height: 48,
        width: 98,
        decoration: BoxDecoration(
          border: Border.all(width: 2.5, color: primary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            if (isBackward)
              const Icon(Icons.chevron_left, color: primary, size: 28),
            Text(
              LocalizationService.getTranslatedMonthYear(label),
              style: const TextStyle(color: primary, fontWeight: FontWeight.bold)
            ),
            if (!isBackward)
              const Icon(Icons.chevron_right, color: primary, size: 28),
          ],
        ),
      );
    }

    void changeTransMonth(type) async {
      if (type == 'forward' && !DateTimeUtil.ableMoveNextMonth(widget.selectedDate)) {
        return;
      }
      TransactionDurationController.switchTransactionMonth(type, widget.selectedDate, (newDate, transactions) {
        String placeholder = '${LocalizationService.currentLanguage == 'km' ? AppLocalizations.of(context)!.month : ''}${LocalizationService.getTranslatedMonth(newDate)}';
        setState(() {
          label = AppLocalizations.of(context)!.cashflowTitle(placeholder);
        });
        widget.updateSelectedDate(newDate);
        context.read<TransactionBloc>().add(LoadTransaction(transactions: transactions));
      });
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16, top: 4),
            child: Text(
              label.toString(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () { changeTransMonth('backward'); },
                child: monthSwitcherBtn(
                  DateTimeUtil.switchDateByMonth('backward', widget.selectedDate),
                  true
                ),
              ),
              TransactionDurationPicker(onDurationChanged: (selectedDuration) {
                durationType = selectedDuration;
                loadPrefixLabel();
              }),
              InkWell(
                onTap: () { changeTransMonth('forward'); },
                child: monthSwitcherBtn(
                  DateTimeUtil.switchDateByMonth('forward', widget.selectedDate),
                  false
                )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
