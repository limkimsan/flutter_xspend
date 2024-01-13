import 'dart:ui';

Color getColorFromHex(String hexColor) {
  String color = hexColor.replaceAll('#', '0xff');
  return Color(int.parse(color));
}