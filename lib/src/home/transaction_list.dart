import 'package:flutter/material.dart';
import 'package:flutter_xspend/src/home/transaction_line_chart.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;

    if (groupedTransactions.isEmpty) {
      return SizedBox(
        height: screenHeight / 2,
        width: double.infinity,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long_outlined, size: 80, color: grey),
            Text('No transaction', style: TextStyle(color: grey, fontSize: 16)),
          ],
        ),
      );
    }

    Widget sectionHeader(transactionDate, total) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 30,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: lightBlack
        ),
        child: Row(
          children: [
            Expanded(child: Text(transactionDate, style: const TextStyle(color: pewter))),
            Text('- KHR $total', style: const TextStyle(color: pewter)),
          ],
        )
      );
    }

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: TransactionLineChart(),
        ),
        for (final trans in groupedTransactions) ...[
          SliverStickyHeader(
            header: sectionHeader(trans['title'], 50000),
            sliver: SliverList.separated(
              separatorBuilder: (context, index) =>
                  const Divider(color: grey),
              itemCount: trans['data'].length,
              itemBuilder: (context, index) => TransactionListItem(
                  item: trans['data'][index], index: index),
            ),
            // List without divider
            // sliver: SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) => TransactionListItem(item: trans['data'][index], index: index),
            //     childCount: trans['data'].length,
            //   ),
            // ),
          ),
        ],
        const SliverPadding(padding: EdgeInsets.only(bottom: 62))
      ],
    );
  }
}