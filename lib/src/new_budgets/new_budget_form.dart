import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/shared/input_label_widget.dart';
import 'package:flutter_xspend/src/new_transaction/currency_type_picker.dart';
import 'package:flutter_xspend/src/utils/datetime_util.dart';
import 'package:flutter_xspend/src/bloc/budget/budget_bloc.dart';
import 'budget_controller.dart';

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
  bool isValid = false;

  void saveBudget() {
    if (_formKey.currentState!.validate() && isValid) {
      _formKey.currentState!.save();
      BudgetController.create(name, amount, startDate, endDate, selectedCurrency, (budgets) {
        context.read<BudgetBloc>().add(LoadBudget(budgets: budgets));
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate(selectedDate, type) async {
      DateTime? firstDate;
      DateTime? lastDate;
      DateTime? initialDate;

      if (type == 'start') {
        initialDate = startDate;
        lastDate = endDate;
      }
      if (type == 'end') {
        initialDate = endDate;
        firstDate = startDate;
      }

      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2024),
        lastDate: lastDate ?? DateTime(2050),
      );

      if (pickedDate != null && !DateTimeUtil.isSameDate(pickedDate, selectedDate)) {
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
            isValid = BudgetController.isValidForm(name, amount, selectedDateTime, endDate);
          }
          else {
            endDate = selectedDateTime;
            isValid = BudgetController.isValidForm(name, amount, startDate, selectedDateTime);
          }
        });
      }
    }

    Widget datePicker(type, onTap) {
      String label = AppLocalizations.of(context)!.selectDate;
      if (type == 'start' && startDate != null) {
        label = DateFormat('dd-MM-yyyy').format(startDate!);
      }
      else if (type == 'end' && endDate != null) {
        label = DateFormat('dd-MM-yyyy').format(endDate!);
      }

      return InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 56,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabelWidget(
                label: type == 'start' ? AppLocalizations.of(context)!.startDate : AppLocalizations.of(context)!.endDate,
                isRequired: true)
              ,
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, color: primary),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      label,
                      style: const TextStyle(color: primary)
                    ),
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
          Text(AppLocalizations.of(context)!.currencyType),
          CurrencyTypePicker(selectedCurrency, (currency) {
            setState(() {
              selectedCurrency = currency;
              isValid = BudgetController.isValidForm(name, amount, startDate, endDate);
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
                  InputLabelWidget(label: AppLocalizations.of(context)!.budgetName, isRequired: true),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.pleaseEnterBudgetName,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.budgetNameIsRequired;
                      }
                      return null;
                    },
                    onSaved: (value) { name = value; },
                    onChanged: (value) {
                      name = value;
                      setState(() {
                        isValid = BudgetController.isValidForm(value, amount, startDate, endDate);
                      });
                    },
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 24),
                  InputLabelWidget(label: AppLocalizations.of(context)!.budgetAmount, isRequired: true,),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.pleaseEnterBudgetAmount,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || int.parse(value) <= 0) {
                        return AppLocalizations.of(context)!.budgetAmountMustBePositiveNumber;
                      }
                      return null;
                    },
                    onSaved: (value) { amount = value; },
                    onChanged: (value) {
                      amount= value;
                      setState(() {
                        isValid = BudgetController.isValidForm(name, value, startDate, endDate);
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      datePicker('start', () { selectDate(startDate, 'start'); }),
                      datePicker('end', () { selectDate(endDate, 'end'); }),
                    ],
                  ),
                  const SizedBox(height: 24),
                  currencyPicker(),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: isValid ? primary : pewter,
              ),
              onPressed: () { saveBudget(); },
              child: Text(
                AppLocalizations.of(context)!.createNewBudget,
                style: Theme.of(context).textTheme.titleMedium
              )
            )
          ],
        ),
      ),
    );
  }
}