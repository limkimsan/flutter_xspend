import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'transaction_list_section_header.dart';
import 'transaction_list_item.dart';
import 'package:flutter_xspend/src/home/transaction_line_chart.dart';
import 'package:flutter_xspend/src/helpers/transaction_helper.dart';
import 'package:flutter_xspend/src/bloc/transaction/transaction_bloc.dart';
import 'package:flutter_xspend/src/bloc/exchange_rate/exchange_rate_bloc.dart';
import 'package:flutter_xspend/src/bloc/base_currency/base_currency_bloc.dart';
import 'package:flutter_xspend/src/utils/initial_util.dart';
import 'package:flutter_xspend/src/constants/font_size.dart';
import 'package:flutter_xspend/src/constants/spacing_constant.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key, required this.hasLineChart, required this.isSlideable});

  final bool hasLineChart;
  final bool isSlideable;
  // final Widget? lineChart;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  void initState() {
    super.initState();
    TransactionHelper.loadTransactions((transactions) {
      context.read<TransactionBloc>().add(LoadTransaction(transactions: transactions));
    });
    loadExchangeRate();
  }

  void loadExchangeRate() {
    InitialUtil.loadCurrencyAndExchangeRate((khrRate, usdRate, basedCurrency) {
      if (khrRate != null) {
        context.read<ExchangeRateBloc>().add(UpdateExchangeRate(exchangeRate: {
          'khr': khrRate as int,
          'usd': usdRate as int
        }));
        if (basedCurrency != null) {
          context.read<BaseCurrencyBloc>().add(UpdateBaseCurrency(currency: basedCurrency));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TransactionBloc>().state;
    final rateState = context.watch<ExchangeRateBloc>().state;
    final currencyState = context.watch<BaseCurrencyBloc>().state;
    double screenHeight = MediaQuery.of(context).size.height;

    if (state.transactions.isEmpty) {
      return SizedBox(
        height: screenHeight / 2,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.receipt_long_outlined, size: 80, color: grey),
            Text('No transaction', style: TextStyle(color: grey, fontSize: mdFontSize)),
          ],
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        if (widget.hasLineChart)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TransactionLineChart(transactions: state.transactions)
            ),
          ),

        for (final trans in TransactionHelper.getGroupedTransactions(state.transactions, rateState.exchangeRate, currencyState.currency)) ...[
          SliverStickyHeader(
            header: TransactionListSectionHeader(transactionDate: trans['title']['date'], total: trans['title']['total']),
            sliver: SliverList.separated(
              itemCount: trans['data'].length,
              itemBuilder: (context, index) => TransactionListItem(
                item: trans['data'][index],
                index: index,
                isSlidable: widget.isSlideable,
                reloadData: (transactions) {
                  context.read<TransactionBloc>().add(LoadTransaction(transactions: transactions));
                }
              ),
              separatorBuilder: (context, index) => const Divider(color: grey, height: 1)
            ),
          )
        ],
        const SliverPadding(padding: EdgeInsets.only(bottom: listPaddingBottom)),
      ],
    );
  }
}