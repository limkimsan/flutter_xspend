import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/utils/color_util.dart';
import 'package:flutter_xspend/src/login/login_controller.dart';
import 'base_currency_bottom_sheet.dart';
import 'exchange_rate_bottom_sheet.dart';
import 'package:flutter_xspend/src/bloc/base_currency/base_currency_bloc.dart';
import 'package:flutter_xspend/src/clean_transaction/clean_transaction_view.dart';
import 'package:flutter_xspend/src/profile/profile_view.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  void onPressItem(type) {
    if (type == 1) {
      const ExchangeRateBottomSheet().showBottomSheet(context);
    }
    else if (type == 2) {
      const BaseCurrencyBottomSheet().showBottomSheet(context);
    }
    else if (type == 3) {
      Navigator.of(context).pushNamed(CleanTransactionView.routeName);
    }
    else {
      Navigator.of(context).pushNamed(ProfileView.routeName);
    }
  }

  Widget listItems(currency) {
    final items = [
      {
        'label': 'Profile',
        'icon': Icons.person,
        'color': lightBlue,
        'type': 0,
      },
      {
        'label': 'Exchange rate',
        'icon': Icons.show_chart_rounded,
        'color': getColorFromHex('#00f6ff'),
        'type': 1,
      },
      {
        'label': 'Base currency',
        'icon': Icons.currency_exchange_outlined,
        'color': lightGreen,
        'type': 2,
      },
      {
        'label': 'Clean transaction',
        'icon': Icons.cleaning_services_outlined,
        'color': red,
        'type': 3,
      },
    ];

    return Column(
      children: items.map<Widget>((item) {
        return Wrap(
          children: [
            ListTile(
              onTap: () { onPressItem(item['type']); },
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
                      Text(currency.toUpperCase(), style: const TextStyle(color: primary, fontSize: 14, fontWeight: FontWeight.bold)),

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
    final state = context.watch<BaseCurrencyBloc>().state;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // hide the back button
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          Flexible(child: listItems(state.currency)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  LoginController.logout(context);
                },
                child: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: primary
                  )
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text('Version ${dotenv.env['APP_VERSION']}', style: const TextStyle(color: grey)),
          )
        ]
      ),
    );
  }
}