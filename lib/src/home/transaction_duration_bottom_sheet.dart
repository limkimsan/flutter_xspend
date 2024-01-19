import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/shared/bottom_sheet/bottom_sheet_body.dart';
import 'package:flutter_xspend/src/utils/string_util.dart';

class TransactionDurationBottomSheet extends StatefulWidget {
  const TransactionDurationBottomSheet({super.key, required this.selectedDuration, required this.updateSelectedDuration});

  final String selectedDuration;
  final void Function(String duration) updateSelectedDuration;

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => this,
    );
  }

  @override
  State<TransactionDurationBottomSheet> createState() => _TransactionDurationBottomSheetState();
}

class _TransactionDurationBottomSheetState extends State<TransactionDurationBottomSheet> {
  void onSelectDuration(duration) async {
    if (duration == 'custom') {
      final DateTimeRange? pickedDate = await showDateRangePicker(
        context: context,
        initialDateRange: DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now().add(const Duration(days: 7)),
        ),
        firstDate: DateTime(2020),
        lastDate: DateTime(2025),
        initialEntryMode:DatePickerEntryMode.calendarOnly,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
              datePickerTheme: const DatePickerThemeData(
                rangeSelectionBackgroundColor: Color.fromARGB(255, 191, 202, 176),
              )
            ),
            child: child!,
          );
        },
      );
      if (pickedDate != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('DATE_RANGE', jsonEncode({'start': pickedDate.start.toString(), 'end': pickedDate.end.toString()}));
      }
      widget.updateSelectedDuration(duration);
      close();
    }
    else {
      widget.updateSelectedDuration(duration);
      close();
    }
  }

  void close() {
    Navigator.of(context).pop();
  }

  Widget durationPicker() {
    List durationTypes = ['week', 'month', 'year', 'custom'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (int i = 0; i < durationTypes.length; i++)
            Wrap(
              children: [
                InkWell(
                  onTap: () { onSelectDuration(durationTypes[i]); },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: Align(alignment: Alignment.centerLeft, child: Text(StringUtil.capitalize(durationTypes[i])))
                        ),
                      ),
                      if (widget.selectedDuration == durationTypes[i])
                        const Icon(Icons.check, color: primary)
                    ],
                  )
                ),
                if (i < durationTypes.length - 1)
                  const Divider(color: grey, height: 0.2)
              ]
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: BottomSheetBody(
        title: 'Base currency',
        titleIcon: const Icon(Icons.currency_exchange_outlined,
            color: lightGreen, size: 26),
        body: durationPicker(),
      ),
    );
  }
}