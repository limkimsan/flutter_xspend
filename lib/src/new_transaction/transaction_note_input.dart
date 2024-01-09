import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';

class TransactionNoteInput extends StatelessWidget {
  const TransactionNoteInput({super.key});

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
            minLines: 5,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Note',
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