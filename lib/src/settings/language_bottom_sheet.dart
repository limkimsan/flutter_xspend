// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/app.dart';
import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/shared/bottom_sheet/bottom_sheet_body.dart';
import 'package:flutter_xspend/src/localization/localization_service.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => this,
    );
  }

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  List locales = [
    {'label': 'English', 'code': 'en', 'country': 'US'},
    {'label': 'Khmer', 'code': 'km', 'country': 'KM'}
  ];

  void onSelectLanguage(languageCode) async {
    Locale temp = await LocalizationService.setLocale(languageCode);
    MyApp.setLocale(context, temp);
    Navigator.of(context).pop();
  }

  Widget localePicker(ctx) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (int i = 0; i < locales.length; i++)
            Wrap(
              children: [
                InkWell(
                  onTap: () {
                    onSelectLanguage(locales[i]['code']);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(locales[i]['label'])
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (i < locales.length - 1)
                  const Divider(color: grey, height: 0.2),
              ],
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: BottomSheetBody(
        title: 'Language',
        titleIcon: const Icon(Icons.translate, color: Colors.white, size: 26),
        body: localePicker(context),
      ),
    );
  }
}