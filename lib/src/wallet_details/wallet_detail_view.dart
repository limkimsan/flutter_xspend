import 'package:flutter/material.dart';

import 'package:flutter_xspend/src/wallet_details/wallet_detail_summary_header.dart';

class WalletDetailView extends StatefulWidget {
  const WalletDetailView({super.key});

  static const routeName = '/wallet_detail';

  @override
  State<WalletDetailView> createState() => _WalletDetailViewState();
}

class _WalletDetailViewState extends State<WalletDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Balance Detail')
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              WalletDetailSummaryHeader(),
            ],
          )
        ),
      ),
    );
  }
}