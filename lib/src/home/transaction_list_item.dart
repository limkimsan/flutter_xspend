import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({super.key, required this.item, required this.index});

  final item;
  final int index;

  @override
  Widget build(BuildContext context) {
    Widget subtitle() {
      return const Column(
        children: [
          Row(
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
                child: Text('jflkajsd flkjasdlkfjaskldfj', style: TextStyle(color: pewter))
              ),
            ],
          ),
        ],
      );
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: const SizedBox(
        height: double.infinity,
        child: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.edit, color: Colors.white, size: 20)
        ),
      ),
      title: Text(item['note'], style: const TextStyle(color: Colors.white),),
      subtitle: subtitle(),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("- KHR ${item['amount']}", style: const TextStyle(color: red, fontSize: 16)),
          const Text('- \$ 1.40', style: TextStyle(color: red, fontSize: 14),),
        ],
      ),
    );
  }
}