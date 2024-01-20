import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'transaction_duration_bottom_sheet.dart';
import 'package:flutter_xspend/src/utils/string_util.dart';
import 'package:flutter_xspend/src/bloc/transaction/transaction_bloc.dart';
import 'package:flutter_xspend/src/new_transaction/transaction_controller.dart';

class TransactionDurationPicker extends StatefulWidget {
  const TransactionDurationPicker({super.key, required this.onDurationChanged});

  final Function() onDurationChanged;

  @override
  State<TransactionDurationPicker> createState() => _TransactionDurationPickerState();
}

class _TransactionDurationPickerState extends State<TransactionDurationPicker> {
  String selectedDuration = 'month';

  @override
  void initState() {
    super.initState();
    loadSelectedDuration();
  }

  void loadSelectedDuration() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedDuration = prefs.getString('TRANSACTION_DURATION') ?? 'month';
    });
  }

  void onDurationChanged(duration) async {
    setState(() {
      selectedDuration = duration;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('TRANSACTION_DURATION', duration);
    reloadTransactionList();
    widget.onDurationChanged();
  }

  void reloadTransactionList() {
    TransactionController.loadTransactions((transactions) {
      context.read<TransactionBloc>().add(LoadTransaction(transactions: transactions));
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        TransactionDurationBottomSheet(
          selectedDuration: selectedDuration,
          updateSelectedDuration: onDurationChanged
        ).showBottomSheet(context);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
        alignment: Alignment.center,
        height: 48,
        width: 115,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primary,
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(StringUtil.capitalize(selectedDuration), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 24),
          ],
        ),
      ),
    );
  }
}