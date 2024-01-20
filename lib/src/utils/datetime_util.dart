class DateTimeUtil {
  static getStartOfMonth(monthIndex) {
    DateTime now = DateTime.now();
    return DateTime(now.year, monthIndex, 1);
  }

  static getEndOfMonth(monthIndex) {
    DateTime now = DateTime.now();
    DateTime startOfNextMonth = DateTime(now.year, monthIndex + 1, 1);
    return startOfNextMonth.subtract(const Duration(days: 1));
  }
}