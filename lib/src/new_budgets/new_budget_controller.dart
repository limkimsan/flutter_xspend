class NewBudgetController {
  static bool isValidForm(name, amount, startDate, endDate) {
    return name != null && name != '' && amount != null && amount != '' && double.parse(amount) > 0 && startDate != null && endDate != null;
  }
}