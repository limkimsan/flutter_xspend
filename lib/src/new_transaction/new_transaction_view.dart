import 'package:flutter/material.dart';

import 'transaction_category_picker.dart';

class NewTransactionView extends StatelessWidget {
  const NewTransactionView({super.key});

  static const routeName = '/new_transaction';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Transaction'),
      ),
      body: const Column(
        children: [
          Text('New transaction content', style: TextStyle(color: Colors.white)),
          TransactionCategoryPicker(),
        ],
      )
    );
  }
}