import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'transaction_category_picker.dart';
import 'currency_type_picker.dart';
import 'transaction_date_picker.dart';
import 'transaction_note_input.dart';
import 'transaction_controller.dart';
import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/models/category.dart';
import 'package:flutter_xspend/src/models/user.dart';
import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:flutter_xspend/src/bloc/transaction_bloc.dart';

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
  String errorMsg = '';
  bool isEdit = false;
  String? selectedTransactionId;
  bool isSending = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      currencyType = 'KHR';
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {  // Schedule a callback to execute after the first frame, where context is available:
      if (ModalRoute.of(context)?.settings.arguments != null) {
        isEdit = true;
        final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
        selectedTransactionId = args['transactionId'];
        TransactionController.getTransactionDetail(args['transactionId'], (transaction) {
          setState(() {
            currencyType = transaction.currencyType;
            date = transaction.transactionDate;
            selectedCategory = transaction.category.value;
          });
          amountController.text = transaction.amount.toString();
          noteController.text = transaction.note;
        });
      }
    });
  }

  void saveTransaction() async {
    if (isSending) {
      return;
    }
    isSending = true;
    setState(() { errorMsg = ''; });
    const uuid = Uuid();
    DateTime tDate = date!.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
    final transaction = Transaction()
                          ..id = isEdit ? selectedTransactionId : uuid.v4()
                          ..amount = double.parse(amountController.text)
                          ..currencyType = currencyType
                          ..note = noteController.text
                          ..transactionType = selectedCategory?.transactionType
                          ..transactionDate = tDate
                          ..synced = false
                          ..category.value = selectedCategory
                          ..user.value = await User.currentLoggedIn();

    if (isEdit) {
      TransactionController.update(transaction, (transactions) {
        context.read<TransactionBloc>().add(LoadTransaction(transactions: transactions));
        Navigator.of(context).pop();
      });
    }
    else {
      TransactionController.create(transaction, () {
        context.read<TransactionBloc>().add(AddNewTransaction(transaction: transaction));
        Navigator.of(context).pop();
      }, (errorMsg) {
        print('== trans error = $errorMsg');
        setState(() {
          errorMsg = 'Failed to create new transaction.';
        });
      });
    }
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
                    TransactionDatePicker(selectedDate: date, updateSelectedDate: (selectedDate) {
                      setState(() { date = selectedDate; });
                      validate('date', date);
                    }),
                    TransactionNoteInput(noteController, (value) {
                      validate('note', value);
                    }),
                  ],
                )
              ),
              if (errorMsg.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(errorMsg, style: const TextStyle(color: red, fontSize: 16)),
                ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: isValid ? primary : pewter,
                  ),
                  onPressed: () { isValid == true ? saveTransaction() : null; },
                  child: Text(
                    isEdit ? 'Update' : 'Create',
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