import 'package:flutter/material.dart';

import 'transaction_category_picker.dart';
import 'currency_type_picker.dart';
import 'transaction_date_picker.dart';
import 'transaction_note_input.dart';
import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/models/category.dart';
import 'transaction_controller.dart';

class NewTransactionView extends StatefulWidget {
  const NewTransactionView({super.key});

  static const routeName = '/new_transaction';

  @override
  State<NewTransactionView> createState() => _NewTransactionViewState();
}

class _NewTransactionViewState extends State<NewTransactionView> {
  String? currencyType;
  DateTime? date;
  Category? selectedCategory;
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  bool isValid = false;
  String? categoryErrorMsg;
  String? amountErrorMsg;
  String? dateErrorMsg;

  @override
  void initState() {
    super.initState();
    setState(() {
      currencyType = 'KHR';
    });
  }

  void createTransaction() {
    print('==== amount ==== ${amountController.text}');
    print('==== category ==== $selectedCategory');
    print('==== note ==== ${noteController.text}');
    print('==== currency ==== $currencyType');
    print('==== date ==== $date');
  }

  void validate(fieldName, value) {
    switch (fieldName) {
      case 'category':
        setState(() {
          isValid = TransactionController.isValid(value, amountController.text, date);
        });
        break;
      case 'date':
        setState(() {
          isValid = TransactionController.isValid(selectedCategory, amountController.text, value);
        });
        break;
      default:
        setState(() {
          isValid = TransactionController.isValid(selectedCategory, amountController.text, date);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Transaction'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Flexible(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TransactionCategoryPicker(selectedCategory: selectedCategory, updateSelectedValue: (category) {
                          setState(() {
                            selectedCategory = category;
                          });
                          validate('category', category);
                          Navigator.of(context).pop();
                        }),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              controller: amountController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              onChanged: (value) => validate('amount', value),
                              decoration: InputDecoration(
                                hintText: 'Transaction amount',
                                hintStyle: const TextStyle(color: pewter, fontSize: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: primary, width: 1.5),
                                ),
                                filled: false,
                              ),
                              style: const TextStyle(color: pewter),
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                            ),
                          ),
                        ),
                        CurrencyTypePicker(currencyType!, (type) {
                          setState(() { currencyType = type; });
                          Navigator.of(context).pop();
                        }),
                      ],
                    ),
                    TransactionDatePicker(updateSelectedDate: (selectedDate) {
                      setState(() { date = selectedDate; });
                      validate('date', date);
                    }),
                    TransactionNoteInput(noteController),
                  ],
                )
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: isValid ? primary : pewter,
                  ),
                  onPressed: () { isValid == true ? createTransaction() : null; },
                  child: Text(
                    'Create',
                    style: Theme.of(context).textTheme.titleMedium
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}