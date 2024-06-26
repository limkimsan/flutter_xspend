import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/shared/bottom_sheet/bottom_sheet_body.dart';
import 'package:flutter_xspend/src/localization/localization_service.dart';

class DeleteConfirmationBottomSheet extends StatefulWidget {
  const DeleteConfirmationBottomSheet({super.key, required this.title, required this.description, required this.onConfirm});

  final String title;
  final String? description;
  final void Function() onConfirm;

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => this,
    );
  }

  @override
  State<DeleteConfirmationBottomSheet> createState() => _DeleteConfirmationBottomSheetState();
}

class _DeleteConfirmationBottomSheetState extends State<DeleteConfirmationBottomSheet> {
  Widget label(String text, Color color) {
    return Padding(
            padding: EdgeInsets.only(top: (LocalizationService.currentLanguage == 'km' && Platform.isIOS) ? 4 : 0),
            child: Text(text, style: TextStyle(color: color)),
          );
  }

  Widget confirmationBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(widget.description.toString()),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: FilledButton(
                    onPressed: () { Navigator.of(context).pop(); },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: label(AppLocalizations.of(context)!.cancel, red),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: FilledButton(
                    onPressed: () {
                      widget.onConfirm();
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(red),
                    ),
                    child: label(AppLocalizations.of(context)!.confirm, Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      // heightFactor: 0.6,
      child: BottomSheetBody(
        title: widget.title,
        titleIcon: const Icon(Icons.delete_outline, color: red, size: 26),
        body: confirmationBody(),
      ),
    );
  }
}