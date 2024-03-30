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

  static switchDateByMonth(type, selectedDate) {
    int currentYear = selectedDate.year;
    int currentMonth = selectedDate.month;
    DateTime newDate = DateTime.now();

    if (type == 'backward') {
      int previousMonth = currentMonth == 1 ? 12 : currentMonth -1;
      int previousYear = currentMonth == 1 ? currentYear - 1 : currentYear;
      newDate = DateTime(previousYear, previousMonth);
    }
    else {
      int nextMonth = currentMonth == 12 ? 1 : currentMonth + 1;
      int nextYear = currentMonth == 12 ? currentYear + 1 : currentYear;
      newDate = DateTime(nextYear, nextMonth);
    }
    return newDate;
  }

  static ableMoveNextMonth(DateTime selectedDate) {
    DateTime now = DateTime.now();
    if (selectedDate.month == now.month && selectedDate.year == now.year) {
      return false;
    }
    return true;
  }

  static isSameDate(DateTime? firstDate, DateTime? secDate) {
    if (firstDate == null || secDate == null) return false;

    return DateTime(firstDate.year, firstDate.month, firstDate.day).isAtSameMomentAs(DateTime(secDate.year, secDate.month, secDate.day));
  }
}