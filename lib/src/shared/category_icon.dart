import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({super.key, required this.type, required this.name, required this.color, this.size});

  final String type;
  final String name;
  final Color color;
  final double? size;

  @override
  Widget build(BuildContext context) {

    const icons = {
      'materialcommunityicons': {
        'cash': MaterialCommunityIcons.cash,
        'gas-station-outline': MaterialCommunityIcons.gas_station_outline,
        'web': MaterialCommunityIcons.web,
        'hammer-wrench': MaterialCommunityIcons.hammer_wrench
      },
      'feather': {
        'refresh-ccw': Feather.refresh_ccw,
        'coffee': Feather.coffee,
        'film': Feather.film,
        'cpu': Feather.cpu,
        'shopping-cart': Feather.shopping_cart,
        'shopping-bag': Feather.shopping_bag
      },
      'ionicons': {
        'fast-food-outline': Ionicons.fast_food_outline,
        'cash-outline': Ionicons.cash_outline,
        'receipt-outline': Ionicons.receipt_outline,
        'car-outline': Ionicons.car_outline,
        'bed-outline': Ionicons.bed_outline,
        'swap-horizontal': Ionicons.swap_horizontal
      },
      'fontawesome': {
        'stethoscope': FontAwesome.stethoscope
      }
    };
    return Icon(icons[type]?[name], color: color, size: size );
  }
}