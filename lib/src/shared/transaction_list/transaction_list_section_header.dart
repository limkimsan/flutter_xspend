import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/localization/localization_service.dart';

class TransactionListSectionHeader extends StatelessWidget {
  const TransactionListSectionHeader({super.key, required this.transactionDate, required this.total});

  final String transactionDate;
  final String total;

  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: Text(
              LocalizationService.getTranslatedFullDate(DateTime.parse(transactionDate)),
              style: const TextStyle(color: pewter)
            ),
          ),
          Text(total, style: const TextStyle(color: pewter)),
        ],
      ),
    );
  }
}