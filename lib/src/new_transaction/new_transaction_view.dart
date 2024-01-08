import 'package:flutter/material.dart';

import 'transaction_category_picker.dart';
import 'package:flutter_xspend/src/constants/colors.dart';

class NewTransactionView extends StatelessWidget {
  const NewTransactionView({super.key});

  static const routeName = '/new_transaction';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const TransactionCategoryPicker(),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: 'Transaction amount',
                        hintStyle: const TextStyle(color: pewter),
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
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}