import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:intl/intl.dart';

class CleanTransactionView extends StatefulWidget {
  const CleanTransactionView({super.key});

  static const routeName = '/clean_transaction';

  @override
  State<CleanTransactionView> createState() => _CleanTransactionViewState();
}

class _CleanTransactionViewState extends State<CleanTransactionView> {
  DateTime? startDate;
  DateTime? endDate;

  void openDatePicker() async {
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
      setState(() {
        startDate = pickedDate.start;
        endDate = pickedDate.end;
      });
    }
  }

  void cleanTransaction() {
    Transaction.deleteByDateRange(startDate, endDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Transaction'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  openDatePicker();
                },
                child: SizedBox(
                  height: 56,
                  child: Row(children: [
                    const Icon(Icons.calendar_today_outlined, color: primary),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        startDate != null
                        ? '${DateFormat('dd/MM/yyyy').format(startDate as DateTime)}    -    ${DateFormat('dd/MM/yyyy').format(endDate as DateTime)}'
                        : 'Please select the start date and end date',
                        style: const TextStyle(
                          color: primary,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                        )
                      ),
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: startDate != null ? primary : pewter,
                  ),
                  onPressed: () {
                    startDate != null ? cleanTransaction() : null;
                  },
                  child: Text('Clean',
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}