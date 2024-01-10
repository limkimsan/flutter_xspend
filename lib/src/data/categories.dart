import 'package:flutter_xspend/src/constants/transaction_constant.dart';
import 'package:flutter_xspend/src/models/category.dart';

final categories = [
  Category(
    "cate1",
    "Salary",
    int.parse(transactionTypes['income']!['value'].toString()),
    1,
    "cash",
    "materialcommunityicons",
    "#ffffff",
    "#66CC00"
  ),
  Category(
    "cate2",
    "Returned fee",
    int.parse(transactionTypes['income']!['value'].toString()),
    3,
    "refresh-ccw",
    "feather",
    "#ffffff",
    "#05c1ff"
  ),
  Category(
    "cate3",
    "Food",
    int.parse(transactionTypes['expense']!['value'].toString()),
    1,
    "fast-food-outline",
    "ionicons",
    "#000000",
    "#FFA500"
  ),
  Category(
    "cate4",
    "Drink",
    int.parse(transactionTypes['expense']!['value'].toString()),
    2,
    "coffee",
    "feather",
    "#ffffff",
    "#6f4e37"
  ),
  Category(
    "cate5",
    "Monthly fee",
    int.parse(transactionTypes['income']!['value'].toString()),
    2,
    "cash-outline",
    "ionicons",
    "#ffffff",
    "#00a300"
  ),
  Category(
    "cate6",
    "Gasoline",
    int.parse(transactionTypes['expense']!['value'].toString()),
    4,
    "gas-station-outline",
    "materialcommunityicons",
    "#ffffff",
    "#dc0404"
  ),
  Category(
    "cate7",
    "Movie",
    int.parse(transactionTypes['expense']!['value'].toString()),
    3,
    "film",
    "feather",
    "#ffffff",
    "#8b949c"
  ),
  Category(
    "cate8",
    "Public service",
    int.parse(transactionTypes['expense']!['value'].toString()),
    5,
    "receipt-outline",
    "ionicons",
    "#fdfcfc",
    "#7a8ef0"
  ),
  Category(
    "cate9",
    "Travel",
    int.parse(transactionTypes['expense']!['value'].toString()),
    6,
    "car-outline",
    "ionicons",
    "#fafafa",
    "#406D5E"
  ),
  Category(
    "cate10",
    "Accommodation",
    int.parse(transactionTypes['expense']!['value'].toString()),
    7,
    "bed-outline",
    "ionicons",
    "#f7f7f7",
    "#0071b8"
  ),
  Category(
    "cate11",
    "Electronic device",
    int.parse(transactionTypes['expense']!['value'].toString()),
    8,
    "cpu",
    "feather",
    "#f7f7f7",
    "#327DF5"
  ),
  Category(
    "cate12",
    "Health care",
    int.parse(transactionTypes['expense']!['value'].toString()),
    9,
    "stethoscope",
    "fontawesome",
    "#ffffff",
    "#52cc00"
  ),
  Category(
    "cate13",
    "Online subscription",
    int.parse(transactionTypes['expense']!['value'].toString()),
    10,
    "web",
    "materialcommunityicons",
    "#fcfcfc",
    "#05e6d7"
  ),
  Category(
    "cate14",
    "Grocery",
    int.parse(transactionTypes['expense']!['value'].toString()),
    11,
    "shopping-cart",
    "feather",
    "#ffffff",
    "#49a300"
  ),
  Category(
    "cate15",
    "Shopping",
    int.parse(transactionTypes['expense']!['value'].toString()),
    12,
    "shopping-bag",
    "feather",
    "#ffffff",
    "#a3a3a3"
  ),
  Category(
    "cate16",
    "Trading",
    int.parse(transactionTypes['income']!['value'].toString()),
    4,
    "swap-horizontal",
    "ionicons",
    "#ffffff",
    "#0030f0"
  ),
  Category(
    "cate17",
    "Utility",
    int.parse(transactionTypes['expense']!['value'].toString()),
    13,
    "hammer-wrench",
    "materialcommunityicons",
    "#ffffff",
    "#14bdb2"
  ),
  Category(
    "cate18",
    "Gasoline",
    int.parse(transactionTypes['expense']!['value'].toString()),
    15,
    "gas-station-outline",
    "materialcommunityicons",
    "#ffffff",
    "#f21c1c"
  )
];