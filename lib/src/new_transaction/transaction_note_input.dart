import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/constants/colors.dart';

class TransactionNoteInput extends StatelessWidget {
  const TransactionNoteInput(this.noteController, this.onChanged, {super.key});

  final TextEditingController noteController;
  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 12),
          child: Icon(Icons.edit, color: primary),
        ),
        Expanded(
          child: TextField(
            controller: noteController,
            minLines: 5,
            maxLines: 5,
            onChanged: (value) => onChanged(value),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.note,
              hintStyle: const TextStyle(color: pewter, fontSize: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: primary, width: 1.5),
              ),
              filled: false,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            ),
            style: const TextStyle(color: pewter),
          ),
        ),
      ],
    );
  }
}