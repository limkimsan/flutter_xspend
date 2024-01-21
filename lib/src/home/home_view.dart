import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_header.dart';
import 'home_transaction_duration.dart';
import 'home_total_expense.dart';
import 'transaction_list.dart';
import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/new_transaction/new_transaction_view.dart';
import 'package:flutter_xspend/src/bloc/transaction/transaction_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.transactionBloc});

  final TransactionBloc transactionBloc;

  static const routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.transactionBloc,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,  // hide the back button
          toolbarHeight: 220,
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: background),
            child: Column(
              children: [
                const HomeHeader(),
                HomeTransactionDuration(selectedDate: selectedDate, updateSelectedDate: (date) {
                  setState(() { selectedDate = date; });
                },),
                HomeTotalExpense(selectedDate: selectedDate),
              ],
            ),
          ),
        ),
        body: const TransactionList(),
        floatingActionButton: SizedBox(
          height: 56,
          width: 56,
          child: FloatingActionButton(
            foregroundColor: Colors.white,
            backgroundColor: primary,
            shape: const CircleBorder(),
            onPressed: () {
              setState(() {
                selectedDate = DateTime.now();
              });
              Navigator.of(context).pushNamed(NewTransactionView.routeName);
            },
            child: const Icon(Icons.add, size: 32),
          ),
        ),
      )
    );
  }
}