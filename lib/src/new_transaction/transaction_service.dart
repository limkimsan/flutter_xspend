import 'package:uuid/uuid.dart';

import 'package:flutter_xspend/src/models/transaction.dart';
import 'package:flutter_xspend/src/models/user.dart';
import 'package:flutter_xspend/src/web/web_service.dart';
import 'package:flutter_xspend/src/utils/url_util.dart';

class TransactionService {
  static sendCreateRequst(transaction) async {
    final params = {
      'category_id': transaction.category.id,
      'amount': double.parse(transaction.amount),
      'transaction_date': transaction.date,
      'note': transaction.note,
      'currency_type': transaction.currencyType,
      'transaction_type': transaction.category.transactionType == 0 ? 'income' : 'expense',
      'user_id': transaction.user.serverId ?? '',
    };

    final url = Uri.parse(UrlUtil.absoluteUrl(UrlUtil.relativeUrl('transactions')));
    return await WebService(isTokenBased: true).post(url, params);
  }

  static createNewInLocal(transaction) {
    Transaction.create(transaction);
  }
}