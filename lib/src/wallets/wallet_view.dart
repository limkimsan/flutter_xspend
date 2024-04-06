import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/wallets/wallet_header.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: background),
          child: const WalletHeader(),
        ),
      ),
      body: const Text('Wallet body'),
    );
  }
}