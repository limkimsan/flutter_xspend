import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/models/category.dart';
import 'package:flutter_xspend/src/utils/color_util.dart';
import 'package:flutter_xspend/src/shared/category_icon.dart';
import 'transaction_category_bottom_sheet.dart';

class TransactionCategoryPicker extends StatelessWidget {
  const TransactionCategoryPicker({super.key, required this.selectedCategory, required this.updateSelectedValue});

  final Category? selectedCategory;
  final void Function(String transactionType, Category category) updateSelectedValue;

  Widget dottedButton() {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(64),
      padding: const EdgeInsets.all(6),
      dashPattern: const [8],
      strokeWidth: 2.5,
      color: primary,
      child: const SizedBox(
        height: 64,
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Select', style: TextStyle(color: primary, fontSize: 12)),
            Text('Category', style: TextStyle(color: primary, fontSize: 12))
          ],
        )
      ),
    );
  }

  Widget iconButton() {
    return Container(
      height: 72,
      width: 72,
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: getColorFromHex(selectedCategory!.bgColor.toString()),
        borderRadius: BorderRadius.circular(56)
      ),
      child: CategoryIcon(
        type: selectedCategory!.iconType.toString(),
        name: selectedCategory!.icon.toString(),
        color: getColorFromHex(selectedCategory!.iconColor.toString()),
        size: 30
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        TransactionCategoryBottomSheet(updateSelectedValue: updateSelectedValue).showBottomSheet(context);
      },
      borderRadius: BorderRadius.circular(64),
      child: selectedCategory == null ? dottedButton() : iconButton(),
    );
  }
}