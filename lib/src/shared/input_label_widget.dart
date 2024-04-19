import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/constants/font_size.dart';

class InputLabelWidget extends StatelessWidget {
  const InputLabelWidget({ super.key, required this.label, this.isRequired = false });

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
    //   child: Text(
    //     label,
    //     style: const TextStyle(
    //       color: Colors.white,
    //     ),
    //   ),
    // );

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          if (isRequired)
            Text(' *', style: TextStyle(color: red, fontSize: mdFontSize)),
        ],
      ),
    );
  }
}