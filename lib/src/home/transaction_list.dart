import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'dummy_data.dart';
import 'transaction_list_item.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
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

    Widget header(groupByValue) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 30,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: lightBlack
        ),
        // child: Text(groupByValue, style: const TextStyle(color: pewter))
        child: Row(
          children: [
            Expanded(child: Text(groupByValue, style: const TextStyle(color: pewter))),
            const Text('- KHR 5000', style: TextStyle(color: pewter)),
          ],
        )
      );
    }

    if (transactions.isNotEmpty) {
      content = Expanded(
        child: GroupedListView<dynamic, String>(
          padding: EdgeInsets.zero,
          elements: transactions,
          groupBy: (element) => element['transaction_date'],
          groupSeparatorBuilder: (String groupByValue) => header(groupByValue),
          itemBuilder: (context, dynamic element) => TransactionListItem(item: element),
          useStickyGroupSeparators: true, // optional
          order: GroupedListOrder.ASC, // optional
          separator: const Divider(color: grey),
        ),
      );
    }

    return content;
  }
}