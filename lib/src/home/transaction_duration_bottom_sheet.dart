import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/shared/bottom_sheet/bottom_sheet_body.dart';
import 'package:flutter_xspend/src/utils/string_util.dart';

class TransactionDurationBottomSheet extends StatefulWidget {
  const TransactionDurationBottomSheet({super.key, required this.selectedDuration, required this.updateSelectedDuration});

  final String selectedDuration;
  final void Function(String duration) updateSelectedDuration;

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => this,
    );
  }

  @override
  State<TransactionDurationBottomSheet> createState() => _TransactionDurationBottomSheetState();
}

class _TransactionDurationBottomSheetState extends State<TransactionDurationBottomSheet> {
  Widget durationPicker() {
    List durationTypes = ['week', 'month', 'year', 'custom'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (int i = 0; i < durationTypes.length; i++)
            Wrap(
              children: [
                InkWell(
                  onTap: () {
                    widget.updateSelectedDuration(durationTypes[i]);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: Align(alignment: Alignment.centerLeft, child: Text(StringUtil.capitalize(durationTypes[i])))
                        ),
                      ),
                      if (widget.selectedDuration == durationTypes[i])
                        const Icon(Icons.check, color: primary)
                    ],
                  )
                ),
                if (i < durationTypes.length - 1)
                  const Divider(color: grey, height: 0.2)
              ]
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: BottomSheetBody(
        title: 'Base currency',
        titleIcon: const Icon(Icons.currency_exchange_outlined,
            color: lightGreen, size: 26),
        body: durationPicker(),
      ),
    );
  }
}