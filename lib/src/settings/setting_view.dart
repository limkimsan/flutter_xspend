import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/utils/color_util.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  Widget listItems() {
    final items = [
      {
        'label': 'Profile',
        'icon': Icons.person,
        'color': lightBlue
      },
      {
        'label': 'Exchange rate',
        'icon': Icons.show_chart_rounded,
        'color': getColorFromHex('#00f6ff')
      },
      {
        'label': 'Base currency',
        'icon': Icons.currency_exchange_outlined,
        'color': lightGreen
      },
      {
        'label': 'Profile',
        'icon': Icons.cleaning_services_outlined,
        'color': red
      },
    ];

    return Column(
      children: items.map<Widget>((item) {
        return Wrap(
          children: [
            ListTile(
              onTap: () { print('==== tap item =='); },
              contentPadding: const EdgeInsets.only(right: 10, left: 16),
              leading: Icon(item['icon'] as IconData, color: item['color'] as Color),
              title: Text(item['label'].toString(), style: const TextStyle(color: Colors.white)),
              trailing: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 80,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (item['label'] == 'Base currency')
                      const Text('USD', style: TextStyle(color: primary, fontSize: 14, fontWeight: FontWeight.bold)),

                    const Icon(Icons.chevron_right_outlined, color: primary, size: 30)
                  ],
                ),
              ),
            ),
            const Divider(color: grey),
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // hide the back button
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          listItems()
        ]
      ),
    );
  }
}