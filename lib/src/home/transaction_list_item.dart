import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/utils/color_util.dart';
import 'package:flutter_xspend/src/shared/category_icon.dart';
import 'package:flutter_xspend/src/constants/transaction_constant.dart';
import 'package:flutter_xspend/src/helpers/transaction_helper.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({super.key, required this.item, required this.index, required this.itemCount});

  // ignore: prefer_typing_uninitialized_variables
  final item;
  final int index;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    Widget subtitle() {
      return Column(
        children: [
          const Row(
            children: [
              Icon(Icons.credit_card, size: 16, color: pewter),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text('USD', style: TextStyle(color: pewter)),
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

    return ListTile(
      contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: index == itemCount - 1 ? 6 : 0),
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
}