import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'transaction_category_picker.dart';
import 'currency_type_picker.dart';
import 'transaction_date_picker.dart';
import 'transaction_note_input.dart';
import 'transaction_controller.dart';
import 'transaction_amount_input.dart';
import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/models/category.dart';
import 'package:flutter_xspend/src/models/user.dart';
import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:flutter_xspend/src/bloc/transaction/transaction_bloc.dart';
import 'package:flutter_xspend/src/utils/currency_util.dart';
import 'package:flutter_xspend/src/utils/datetime_util.dart';

class NewTransactionView extends StatefulWidget {
  const NewTransactionView({super.key});

  static const routeName = '/new_transaction';

  @override
  State<NewTransactionView> createState() => _NewTransactionViewState();
}

class _NewTransactionViewState extends State<NewTransactionView> {
  String currencyType = 'khr';
  DateTime? date;
  Category? selectedCategory;
  String amount = '';
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  bool isValid = false;
  String errorMsg = '';
  bool isEdit = false;
  String? selectedTransactionId;
  bool isSending = false;
  DateTime? defaultDate;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {  // Schedule a callback to execute after the first frame, where context is available:
      if (ModalRoute.of(context)?.settings.arguments != null) {
        isEdit = true;
        final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
        selectedTransactionId = args['transactionId'];
        TransactionController.getTransactionDetail(args['transactionId'], (transaction) {
          setState(() {
            currencyType = transaction.currencyType;
            date = transaction.transactionDate;
            selectedCategory = transaction.category.value;
            amount = transaction.amount.toString();
          });
          defaultDate = transaction.transactionDate;
          amountController.text = CurrencyUtil.formatNumber(transaction.amount.toString());
          noteController.text = transaction.note;
        });
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        currencyType = prefs.getString('BASED_CURRENCY').toString();
      });
    });
  }

  void saveTransaction() async {
    if (isSending) {
      return;
    }

    isSending = true;
    setState(() { errorMsg = ''; });
    const uuid = Uuid();
    final transaction = Transaction()
                          ..id = isEdit ? selectedTransactionId : uuid.v4()
                          ..amount = double.parse(amount)
                          ..currencyType = currencyType
                          ..note = noteController.text
                          ..transactionType = selectedCategory?.transactionType
                          ..transactionDate = DateTimeUtil.isSameDate(date, defaultDate) ? defaultDate : date
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
      TransactionController.create(transaction, (transactions) {
        // context.read<TransactionBloc>().add(AddNewTransaction(transaction: transaction));   // for add new transaction to the current transaction state
        context.read<TransactionBloc>().add(LoadTransaction(transactions: transactions));
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
          isValid = TransactionController.isValid(value, amount, date);
        });
        break;
      case 'date':
        setState(() {
          isValid = TransactionController.isValid(selectedCategory, amount, value);
        });
        break;
      default:
        setState(() {
          isValid = TransactionController.isValid(selectedCategory, amount, date);
        });
    }
  }

  void onAmountChange(value) {
    amount = value;
    validate('amount', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(isEdit ? AppLocalizations.of(context)!.editTransaction : AppLocalizations.of(context)!.createNewTransaction),
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
                        TransactionAmountInput(
                          controller: amountController,
                          onChange: onAmountChange
                        ),
                        CurrencyTypePicker(currencyType, (type) {
                          setState(() { currencyType = type; });
                          validate('currency', type);
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
                    isEdit ? AppLocalizations.of(context)!.update : AppLocalizations.of(context)!.create,
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