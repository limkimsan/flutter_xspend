import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_xspend/src/constants/colors.dart';

class TransactionDatePicker extends StatefulWidget {
  const TransactionDatePicker({super.key, required this.updateSelectedDate});

  final void Function(DateTime date) updateSelectedDate;

  @override
  State<TransactionDatePicker> createState() => _TransactionDatePickerState();
}

class _TransactionDatePickerState extends State<TransactionDatePicker> {
  DateTime? selectedDate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
      widget.updateSelectedDate(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 22),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {selectDate(context);},
              child: SizedBox(
                height: 48,
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, color: primary),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        selectedDate == null ? 'Select transaction date' : DateFormat('dd-MM-yyyy').format(selectedDate!),
                        style: const TextStyle(color: primary, fontSize: 15, fontWeight: FontWeight.w500)
                      ),
                    ),
                  ]
                ),
              ),
            ),
          ),
      
          OutlinedButton(
            onPressed: () {
              setState(() {
                selectedDate = DateTime.now();
              });
              widget.updateSelectedDate(DateTime.now());
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: primary, width: 2.5),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(15.0), // Adjust radius
              // ),
            ),
            child: const Text('Today', style: TextStyle(fontSize: 15)),
          )
        ],
      ),
    );
  }
}