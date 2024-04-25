import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/shared/input_label_widget.dart';
import 'package:flutter_xspend/src/new_transaction/currency_type_picker.dart';
import 'package:flutter_xspend/src/utils/datetime_util.dart';
import 'package:flutter_xspend/src/utils/currency_util.dart';
import 'package:flutter_xspend/src/bloc/budget/budget_bloc.dart';
import 'package:flutter_xspend/src/models/budget.dart';
import 'package:flutter_xspend/src/shared/currency_text_field.dart';
import 'budget_controller.dart';

class NewBudgetForm extends StatefulWidget {
  const NewBudgetForm({super.key, this.budgetId});

  final String? budgetId;

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.budgetId != null) {
      loadBudgetInfo();
    }
  }

  void loadBudgetInfo() async {
    Budget budget = await Budget.findById(widget.budgetId!);
    setState(() {
      name = budget.name;
      amount = budget.amount.toString();
      startDate = budget.startDate;
      endDate = budget.endDate;
      selectedCurrency = budget.currencyType!;
    });
    _nameController.text = budget.name!;
    _amountController.text = CurrencyUtil.formatNumber(budget.amount.toString());
  }

  void saveBudget() {
    if (_formKey.currentState!.validate() && isValid) {
      _formKey.currentState!.save();
      if (widget.budgetId != null) {
        BudgetController.update(widget.budgetId, name, amount, startDate, endDate, selectedCurrency, (newBudgets, tranList) {
          reloadBudgetList(newBudgets, tranList);
        });
      }
      else {
        BudgetController.create(name, amount, startDate, endDate, selectedCurrency, (newBudgets, tranList) {
          reloadBudgetList(newBudgets, tranList);
        });
      }
    }
  }

  void reloadBudgetList(budgets, tranList) {
    context.read<BudgetBloc>().add(LoadBudget(budgets: budgets, tranList: tranList));
    Navigator.of(context).pop();
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
        setState(() {
          if (type == 'start') {
            startDate = pickedDate;
            isValid = BudgetController.isValidForm(name, amount, pickedDate, endDate);
          }
          else {
            final newEndDate = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, 23, 59, 59, 999);
            endDate = newEndDate;
            isValid = BudgetController.isValidForm(name, amount, startDate, newEndDate);
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
                    controller: _nameController,
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
                  CurrencyTextField(
                    hintText: AppLocalizations.of(context)!.pleaseEnterBudgetAmount,
                    controller: _amountController,
                    onChanged: (value) {
                      amount= value;
                      setState(() {
                        isValid = BudgetController.isValidForm(name, value, startDate, endDate);
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || double.parse(value) <= 0) {
                        return AppLocalizations.of(context)!.budgetAmountMustBePositiveNumber;
                      }
                      return null;
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
              style: ElevatedButton.styleFrom(primary: isValid ? primary : pewter),
              onPressed: () { saveBudget(); },
              child: Text(
                widget.budgetId == null ? AppLocalizations.of(context)!.create : AppLocalizations.of(context)!.update,
                style: Theme.of(context).textTheme.titleMedium
              )
            )
          ],
        ),
      ),
    );
  }
}