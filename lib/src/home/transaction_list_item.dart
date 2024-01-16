import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/new_transaction/new_transaction_view.dart';
import 'package:flutter_xspend/src/utils/color_util.dart';
import 'package:flutter_xspend/src/shared/category_icon.dart';
import 'package:flutter_xspend/src/constants/transaction_constant.dart';
import 'package:flutter_xspend/src/helpers/transaction_helper.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({super.key, required this.item, required this.index});

  // ignore: prefer_typing_uninitialized_variables
  final item;
  final int index;

  @override
  Widget build(BuildContext context) {
    Widget subtitle() {
      return Column(
        children: [
          Row(
            children: [
              const Icon(Icons.credit_card, size: 16, color: pewter),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(item.currencyType, style: const TextStyle(color: pewter)),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(item.note.toString(), style: const TextStyle(color: pewter))
              ),
            ],
          ),
        ],
      );
    }

    Widget listItem() {
      return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: SizedBox(
          height: double.infinity,
          child: CircleAvatar(
            backgroundColor: getColorFromHex(item.category.value.bgColor),
            child: CategoryIcon(type: item.category.value.iconType, name: item.category.value.icon, color: getColorFromHex(item.category.value.iconColor), size: 20)
          ),
        ),
        title: Text(item.category.value.name, style: const TextStyle(color: Colors.white),),
        subtitle: subtitle(),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (int i = 0; i < currencyTypes.length; i++)
              Text(
                TransactionHelper.getFormattedAmount(item.transactionType, 'usd', item.amount, item.currencyType, {'khr': 4100, 'usd': 1}),
                // TransactionHelper.getFormattedAmount(0, 'usd', item.amount, 'usd', {'khr': 4100, 'usd': 1}),
                style: TextStyle(color: item.transactionType == 1 ? red : success, fontSize: i == 0 ? 16 : 14)
              ),
          ]
        ),
      );
    }

    // Todo: make the the list item update after editing the transaction

    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),
      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) { Navigator.of(context).pushNamed(NewTransactionView.routeName, arguments: { 'transactionId': item.id }); },
            backgroundColor: lightBlue,
            foregroundColor: Colors.white,
            icon: Icons.edit_outlined,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: red,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
            label: 'Save',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: listItem(),
    );

  }
}