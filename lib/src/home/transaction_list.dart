import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final List transactions = [];

  @override
  Widget build(BuildContext context) {
    Widget content = const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 80, color: grey),
          Text(
            'No transaction',
            style: TextStyle(
              color: grey,
              fontSize: 16
            )
          ),
        ],
      ),
    );

    return content;
  }
}