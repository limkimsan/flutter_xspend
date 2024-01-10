import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({super.key, required this.type, required this.name, required this.color});

  final String type;
  final String name;
  final Color color;

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


    // final icons = {
    //   'materialcommunityicons': {
    //     'cash': Icon(MaterialCommunityIcons.cash, color: color),
    //     'gas-station-outline': Icon(MaterialCommunityIcons.gas_station_outline, color: color),
    //     'web': Icon(MaterialCommunityIcons.web, color: color),
    //     'hammer-wrench': Icon(MaterialCommunityIcons.hammer_wrench, color: color)
    //   },
    //   'feather': {
    //     'refresh-ccw': Icon(Feather.refresh_ccw, color: color),
    //     'coffee': Icon(Feather.coffee, color: color),
    //     'film': Icon(Feather.film, color: color),
    //     'cpu': Icon(Feather.cpu, color: color),
    //     'shopping-cart': Icon(Feather.shopping_cart, color: color),
    //     'shopping-bag': Icon(Feather.shopping_bag)
    //   },
    //   'ionicons': {
    //     'fash-food-outline': Icon(Ionicons.fast_food_outline),
    //     'cash-outline': Icon(Ionicons.cash_outline),
    //     'receipt-outline': Icon(Ionicons.receipt_outline),
    //     'car-outline': Icon(Ionicons.car_outline),
    //     'bed-outline': Icon(Ionicons.bed_outline),
    //     'swap-horizontal': Icon(Ionicons.swap_horizontal)
    //   },
    //   'fontawesome': {
    //     'stethoscope': Icon(FontAwesome.stethoscope)
    //   }
    // };
    return Icon(icons[type]?[name], color: color);
  }
}