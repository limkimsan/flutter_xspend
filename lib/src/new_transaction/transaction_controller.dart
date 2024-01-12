// import 'package:flutter_xspend/src/models/category.dart';

class TransactionController {
  static isValid(category, amount, date) {
    return category != null && amount != '' && date != null;
  }

  static getValidationMsg(fieldName, value) {
    if (value == '' || value == null) {
      return '$fieldName is required';
    } else if (fieldName == 'amount' && value >= 0) {
      return 'Amount must be postivive number';
    }

    return '';
  }
}