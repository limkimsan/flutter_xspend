import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/constants/font_size.dart';

class BudgetEmptyMessage extends StatelessWidget {
  const BudgetEmptyMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.receipt_long_outlined, size: 80, color: grey),
            Text(AppLocalizations.of(context)!.noBudgetCreated, style: TextStyle(color: grey, fontSize: lgHeader)),
          ],
        ),
      ],
    );
  }
}