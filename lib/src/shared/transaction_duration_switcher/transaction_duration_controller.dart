import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:flutter_xspend/src/utils/datetime_util.dart';

class TransactionDurationController {
  static switchTransactionMonth(type, selectedDate, callback) async {
    DateTime newDate = DateTimeUtil.switchDateByMonth(type, selectedDate);
    DateTime startOfNextMonth = DateTime(newDate.year, newDate.month + 1, 1);

    List transactions = await Transaction.getAllByDurationType(
                                'custom',
                                DateTime(newDate.year, newDate.month, 1).toString(),
                                startOfNextMonth.subtract(const Duration(days: 1)).toString()
                              );
    callback?.call(newDate, transactions);
  }
}