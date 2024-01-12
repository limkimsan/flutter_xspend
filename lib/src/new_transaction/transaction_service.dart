import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:flutter_xspend/src/web/web_service.dart';
import 'package:flutter_xspend/src/utils/url_util.dart';
import 'package:flutter_xspend/src/constants/transaction_constant.dart';

class TransactionService {
  static sendCreateRequest(transaction) async {
    final params = {
      'category_id': transaction.category.value.id,
      'amount': transaction.amount,
      'transaction_date': transaction.transactionDate.toString(),
      'note': transaction.note,
      'currency_type': currencyTypes[transaction.currencyType],
      'transaction_type': transaction.category.value.transactionType == 0 ? 'income' : 'expense',
      'user_id': transaction.user.value.serverId ?? '',
    };

    final url = Uri.parse(UrlUtil.absoluteUrl(UrlUtil.relativeUrl('transactions')));
    return await WebService(isTokenBased: true).post(url, params);
  }

  static createNewInLocal(transaction) {
    Transaction.create(transaction);
  }
}