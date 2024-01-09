import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';

class BottomSheetBody extends StatelessWidget {
  const BottomSheetBody({super.key, required this.title, this.titleIcon, required this.body});

  final String title;
  final Widget? titleIcon;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: bottomSheetBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      // padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 28),
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
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                if (titleIcon != null)
                  titleIcon!,

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white, thickness: 0.4),
          body
        ],
      ),
    );
  }
}