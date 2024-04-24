import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:intl/intl.dart';

import 'package:flutter_xspend/src/constants/colors.dart';
import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:flutter_xspend/src/new_transaction/new_transaction_view.dart';
import 'package:flutter_xspend/src/new_transaction/transaction_controller.dart';
import 'package:flutter_xspend/src/shared/bottom_sheet/delete_confirmation_bottom_sheet.dart';
import 'package:flutter_xspend/src/utils/color_util.dart';
import 'package:flutter_xspend/src/shared/category_icon.dart';
import 'package:flutter_xspend/src/constants/transaction_constant.dart';
import 'package:flutter_xspend/src/helpers/transaction_helper.dart';
import 'package:flutter_xspend/src/bloc/exchange_rate/exchange_rate_bloc.dart';
import 'package:flutter_xspend/src/localization/localization_service.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    super.key,
    required this.item,
    required this.index,
    required this.isSlidable,
    this.reloadData
  });

  // ignore: prefer_typing_uninitialized_variables
  final item;
  final int index;
  final bool isSlidable;
  final void Function(List<Transaction> transactions)? reloadData;
  // final void Function(List<Transaction> transactions) reloadData;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ExchangeRateBloc>().state;

    Widget subtitle() {
      return Column(
        children: [
          Row(
            children:[
              const Icon(Icons.credit_card, size: 16, color: pewter),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(item.currencyType.toString(), style: const TextStyle(color: pewter))
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(item.note.toString(), style: const TextStyle(color: pewter)),
              )
            ],
          ),
        ],
      );
    }

    Widget listItem() {
      return ListTile(
        dense: false,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: SizedBox(
          height: double.infinity,
          child: CircleAvatar(
            backgroundColor: getColorFromHex(item.category.value!.bgColor.toString()),
            child: CategoryIcon(
              type: item.category.value!.iconType.toString(),
              name: item.category.value!.icon.toString(),
              color: getColorFromHex(item.category.value!.iconColor.toString()),
              size: 20
            )
          )
        ),
        title: Text(
          LocalizationService.currentLanguage == 'km' ? item.category.value!.nameKm.toString() : item.category.value!.name.toString(),
          style: const TextStyle(color: Colors.white)
        ),
        subtitle: subtitle(),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < currencyTypes.length; i++)
              Expanded(
                child: Text(
                  TransactionHelper.getFormattedAmount(
                    item.transactionType,
                    currencyTypes[i]['value'],
                    item.amount,
                    item.currencyType,
                    state.exchangeRate
                  ),
                  style: TextStyle(
                    color: item.transactionType == 1 ? red : success,
                    fontSize: i == 0 ? 14 : 13
                  )
                ),
              ),

            Text(
              LocalizationService.getTranslatedDateMonth(item.transactionDate),
              style: const TextStyle(color: pewter, fontSize: 12)
            ),
          ],
        ),
      );
    }

    if (isSlidable && reloadData != null) {
      return Slidable(
        // Specify a key if the Slidable is dismissible.
        // key: const ValueKey(0),
        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.of(context).pushNamed(NewTransactionView.routeName, arguments: {'transactionId': item.id});
              },
              backgroundColor: lightBlue,
              foregroundColor: Colors.white,
              icon: Icons.edit_outlined,
              label: AppLocalizations.of(context)!.edit
            ),
            SlidableAction(
              onPressed: (context) {
                DeleteConfirmationBottomSheet(
                  title: AppLocalizations.of(context)!.deleteTransaction,
                  description: AppLocalizations.of(context)!.areYouSureToDeleteThisTransaction,
                  onConfirm: () {
                    TransactionController.delete(item.id, (transactions) {
                      reloadData!(transactions);
                    });
                  }
                ).showBottomSheet(context);
              },
              backgroundColor: red,
              foregroundColor: Colors.white,
              icon: Icons.delete_outline,
              label: AppLocalizations.of(context)!.delete
            ),
          ],
        ),
        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: listItem(),
      );
    }

    return listItem();
  }
}