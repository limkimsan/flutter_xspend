import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/constants/transaction_constant.dart';
import 'package:flutter_xspend/src/shared/bottom_sheet/bottom_sheet_body.dart';
import 'package:flutter_xspend/src/shared/category_icon.dart';
import 'package:flutter_xspend/src/models/category.dart';
import 'package:flutter_xspend/src/utils/color_util.dart';

class TransactionCategoryBottomSheet extends StatefulWidget {
  const TransactionCategoryBottomSheet({super.key});

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => this,
    );
  }

  @override
  State<TransactionCategoryBottomSheet> createState() => _TransactionCategoryBottomSheetState();
}

class _TransactionCategoryBottomSheetState extends State<TransactionCategoryBottomSheet> {
  List categories = [];
  String selectedType = 'expense';
  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  void loadCategories() async {
    final cateList = await Category.expenseCategories();
    setState(() {
      categories = cateList;
    });
  }

  void switchType(type) async {
    final cateList = type == 'expense'
        ? await Category.expenseCategories()
        : await Category.incomeCategoies();
    setState(() {
      categories = cateList;
      selectedType = type;
    });
  }

  Widget tabButton(type) {
    final color = selectedType != type ? { 'label': darkGrey, 'background': pewter } : { 'label': Colors.white, 'background': transactionTypes[type]!['color'] as Color };

    return Expanded(
      key: UniqueKey(),
      child: Container(
        margin: type == 'expense'
          ? const EdgeInsets.only(right: 10)
          : const EdgeInsets.only(left: 10),
        child: FilledButton.icon(
          onPressed: () { switchType(type); },
          icon: Icon(transactionTypes[type]!['icon'] as IconData?, color: color['label']),
          label: Text(
            transactionTypes[type]!['label'].toString(),
            style: TextStyle(color: color['label']),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color['background']!),
          )
        ),
      ),
    );
  }

  Widget categoryItem(category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            child: Container(
              height: 56,
              width: 56,
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: getColorFromHex(category.bgColor),
                borderRadius: BorderRadius.circular(56)
              ),
              child: CategoryIcon(type: category.iconType, name: category.icon, color: getColorFromHex(category.iconColor)),
            ),
          ),
          SizedBox(
            width: 56,
            child: Text(
              category.name,
              style: const TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheetChild() {
    return BottomSheetBody(
      title: 'Transaction category',
      titleIcon: const Icon(Icons.category_outlined, size: 34, color: Colors.orange),
      body: transactionCateBottomSheet()
    );
  }

  Widget transactionCateBottomSheet() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tabButton('expense'),
                  tabButton('income'),
                ],
              ),
            ),
            Flexible(     // make the its height fill the rest of its parent widget
              child: SizedBox(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Wrap(
                        spacing: 45,
                        children: [
                          for (int i = 0; i < categories.length; i++)
                            categoryItem(categories[i]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: bottomSheetChild(),
    );
  }
}