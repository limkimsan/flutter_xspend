import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_header.dart';
import 'home_transaction_duration.dart';
import 'transaction_list.dart';
import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/new_transaction/new_transaction_view.dart';
import 'package:flutter_xspend/src/bloc/transaction_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TransactionBloc transactionBloc = TransactionBloc();

  @override
  void dispose() {
    transactionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 220,
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: background),
          child: Column(
            children: [
              const HomeHeader(),
              const HomeTransactionDuration(),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 0, right: 16, top: 16),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Total expense', style: TextStyle(color: grey)),
                      Text('- KHR 0', style: TextStyle(color: red)),
                      Text('- \$ 0', style: TextStyle(color: red)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Builder(
        builder: (_) => BlocProvider(
          create: (ctx) => transactionBloc,
          child: const TransactionList(),
        )
      ),
      floatingActionButton: SizedBox(
        height: 56,
        width: 56,
        child: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: primary,
          shape: const CircleBorder(),
          onPressed: () { Navigator.of(context).pushNamed(NewTransactionView.routeName); },
          child: const Icon(Icons.add, size: 32),
        ),
      ),
    );
  }
}