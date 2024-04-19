import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/shared/input_label_widget.dart';
import 'package:flutter_xspend/src/new_transaction/currency_type_picker.dart';

class NewBudgetForm extends StatefulWidget {
  const NewBudgetForm({super.key});

  @override
  State<NewBudgetForm> createState() => _NewBudgetFormState();
}

class _NewBudgetFormState extends State<NewBudgetForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? amount;
  DateTime? startDate;
  DateTime? endDate;
  String selectedCurrency = 'khr';

  void saveBudget() {
    _formKey.currentState!.save();
    print('=== save budget ====');
    print('= name = $name | amount = $amount | start date = $startDate | end date = $endDate | currency = $selectedCurrency');
  }

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate(selectedDate, type) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2024),
        lastDate: DateTime(2026),
      );
      if (pickedDate != null && pickedDate != selectedDate) {
        final now = DateTime.now();
        final selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          now.hour,
          now.minute,
          now.second,
          now.millisecond,
          now.microsecond
        );
        setState(() {
          if (type == 'start') {
            startDate = selectedDateTime;
          }
          else {
            endDate = selectedDateTime;
          }
        });
      }
    }

    Widget datePicker(title, onTap) {
      return InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 56,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabelWidget(label: title, isRequired: true),
              const Row(
                children: [
                  Icon(Icons.calendar_today_outlined, color: primary),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('Select date', style: TextStyle(color: primary)),
                  )
                ],
              ),
            ],
          )
        ),
      );
    }

    Widget currencyPicker() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Currency type'),
          CurrencyTypePicker(selectedCurrency, (currency) {
            setState(() {
              selectedCurrency = currency;
            });
            Navigator.of(context).pop();
          })
        ],
      );
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const InputLabelWidget(label: 'Budget name', isRequired: true),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Please enter your budget name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Budget name is required';
                      }
                      return null;
                    },
                    onSaved: (value) { name = value; },
                  ),
                  const SizedBox(height: 24),
                  const InputLabelWidget(label: 'Budget amount', isRequired: true,),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Please enter your buget amount',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || int.parse(value) <= 0) {
                        return 'Budget amount must be positive number';
                      }
                      return null;
                    },
                    onSaved: (value) { amount = value; },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      datePicker('Start date', () { selectDate(startDate, 'start'); }),
                      datePicker('End date', () { selectDate(endDate, 'end'); }),
                    ],
                  ),
                  const SizedBox(height: 24),
                  currencyPicker(),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () { saveBudget(); },
              child: Text(
                'Create new budget',
                style: Theme.of(context).textTheme.titleMedium
              )
            )
          ],
        ),
      ),
    );
  }
}