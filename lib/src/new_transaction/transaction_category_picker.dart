import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter_xspend/src/constants/colors.dart';

class TransactionCategoryPicker extends StatefulWidget {
  const TransactionCategoryPicker({super.key});

  @override
  State<TransactionCategoryPicker> createState() => _TransactionCategoryPickerState();
}

class _TransactionCategoryPickerState extends State<TransactionCategoryPicker> {
  Widget tabButton(type) {
    final types = {
      'expense': { 'label': 'Expense', 'icon': const Icon(Icons.arrow_circle_up_outlined), 'color': red },
      'income': { 'label': 'Incom', 'icon': const Icon(Icons.arrow_circle_down_outlined), 'color': success }
    };

    return Expanded(
      child: Container(
        margin: type == 'expense' ? const EdgeInsets.only(right: 10) : const EdgeInsets.only(left: 10),
        child: FilledButton.icon(
          onPressed: () {},
          icon: types[type]!['icon'] as Icon,
          label: Text(types[type]!['label'].toString()),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(types[type]!['color'] as Color),
          )
        ),
      ),
    );
  }

  Widget categoryItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 56,
            width: 56,
            margin: const EdgeInsets.only(bottom: 4),
            child: IconButton.filled(
              onPressed: () {},
              icon: const Icon(Icons.search)
            ),
          ),
          const Text('Food', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget bottomSheetChild() {
    return Container(
      decoration: const BoxDecoration(
        color: bottomSheetBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: pewter,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                const Icon(Icons.category_outlined,
                    size: 34, color: Colors.orange),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Transaction category',
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: grey),
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
          Flexible(      // make the its height fill the rest of its parent widget
            child: SizedBox(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Wrap(
                      // spacing: 40,
                      spacing: 45,
                      children: [
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                        categoryItem(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.6,
        child: bottomSheetChild(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {showBottomSheet(context);},
      borderRadius: BorderRadius.circular(64),
      child: DottedBorder(
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
      ),
    );
  }
}