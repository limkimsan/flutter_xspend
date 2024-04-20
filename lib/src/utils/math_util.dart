class MathUtil {
  static getFormattedPercentage(value) {
    String percentage = (value * 100).toStringAsFixed(2);
    List<String> parts = percentage.split('.');

    if (parts.length == 2 && parts[1].replaceAll("0", "").isEmpty) {
      return '${parts[0]}%';
    }
    return '$percentage%';
  }
}