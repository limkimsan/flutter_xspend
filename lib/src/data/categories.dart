import 'package:flutter_xspend/src/constants/transaction_constant.dart';
import 'package:flutter_xspend/src/models/category.dart';

final categories = [
  Category(
    "2529fa6d-a529-44ce-8949-57275d179793",
    "Salary",
    int.parse(transactionTypes['income']!['value'].toString()),
    1,
    "cash",
    "materialcommunityicons",
    "#ffffff",
    "#66CC00"
  ),
  Category(
    "50f5573b-cf95-4fef-9916-41d5ef2fd05e",
    "Returned fee",
    int.parse(transactionTypes['income']!['value'].toString()),
    3,
    "refresh-ccw",
    "feather",
    "#ffffff",
    "#05c1ff"
  ),
  Category(
    "4e48297e-099c-4dcf-a620-31a7f398a36c",
    "Food",
    int.parse(transactionTypes['expense']!['value'].toString()),
    1,
    "fast-food-outline",
    "ionicons",
    "#000000",
    "#FFA500"
  ),
  Category(
    "e95e4f02-a1b6-4c87-9d10-df03836ea490",
    "Drink",
    int.parse(transactionTypes['expense']!['value'].toString()),
    2,
    "coffee",
    "feather",
    "#ffffff",
    "#6f4e37"
  ),
  Category(
    "cc92ad4c-9d7b-42c3-8c83-9c9529466559",
    "Monthly fee",
    int.parse(transactionTypes['income']!['value'].toString()),
    2,
    "cash-outline",
    "ionicons",
    "#ffffff",
    "#00a300"
  ),
  Category(
    "fe318f3f-0c6e-4c3d-a013-6b20cf719f03",
    "Gasoline",
    int.parse(transactionTypes['expense']!['value'].toString()),
    4,
    "gas-station-outline",
    "materialcommunityicons",
    "#ffffff",
    "#dc0404"
  ),
  Category(
    "99bc1b73-709b-4888-8cae-dd808f95bfa5",
    "Movie",
    int.parse(transactionTypes['expense']!['value'].toString()),
    3,
    "film",
    "feather",
    "#ffffff",
    "#8b949c"
  ),
  Category(
    "52962d0f-0303-482d-bec1-859a6539fbd3",
    "Public service",
    int.parse(transactionTypes['expense']!['value'].toString()),
    5,
    "receipt-outline",
    "ionicons",
    "#fdfcfc",
    "#7a8ef0"
  ),
  Category(
    "dfb49315-e55d-4429-afe6-22196e0b738a",
    "Travel",
    int.parse(transactionTypes['expense']!['value'].toString()),
    6,
    "car-outline",
    "ionicons",
    "#fafafa",
    "#406D5E"
  ),
  Category(
    "83b138e2-426c-4c8c-8532-5276362b91f0",
    "Accommodation",
    int.parse(transactionTypes['expense']!['value'].toString()),
    7,
    "bed-outline",
    "ionicons",
    "#f7f7f7",
    "#0071b8"
  ),
  Category(
    "3dcfaf97-75cb-4d48-8c55-6dbf88bbe053",
    "Electronic device",
    int.parse(transactionTypes['expense']!['value'].toString()),
    8,
    "cpu",
    "feather",
    "#f7f7f7",
    "#327DF5"
  ),
  Category(
    "dc071198-5bf2-4408-8cc5-cecb6256f2d3",
    "Health care",
    int.parse(transactionTypes['expense']!['value'].toString()),
    9,
    "stethoscope",
    "fontawesome",
    "#ffffff",
    "#52cc00"
  ),
  Category(
    "cf12bacd-b5b4-4eca-8df2-3bae524e2160",
    "Online subscription",
    int.parse(transactionTypes['expense']!['value'].toString()),
    10,
    "web",
    "materialcommunityicons",
    "#fcfcfc",
    "#05e6d7"
  ),
  Category(
    "ada9772b-498f-4619-8962-7ad0c15ebca9",
    "Grocery",
    int.parse(transactionTypes['expense']!['value'].toString()),
    11,
    "shopping-cart",
    "feather",
    "#ffffff",
    "#49a300"
  ),
  Category(
    "97cb519e-2b22-45a5-a859-339cf83cef02",
    "Shopping",
    int.parse(transactionTypes['expense']!['value'].toString()),
    12,
    "shopping-bag",
    "feather",
    "#ffffff",
    "#a3a3a3"
  ),
  Category(
    "ebc67a95-64f8-4574-9c1d-6a96e0672f4a",
    "Trading",
    int.parse(transactionTypes['income']!['value'].toString()),
    4,
    "swap-horizontal",
    "ionicons",
    "#ffffff",
    "#0030f0"
  ),
  Category(
    "b1540a66-be03-4bf8-9121-57c5b94cf7f7",
    "Utility",
    int.parse(transactionTypes['expense']!['value'].toString()),
    13,
    "hammer-wrench",
    "materialcommunityicons",
    "#ffffff",
    "#14bdb2"
  ),
  Category(
    "7296ae1e-5561-4e6a-9fc9-b8faa4ab2671",
    "Gasoline",
    int.parse(transactionTypes['expense']!['value'].toString()),
    15,
    "gas-station-outline",
    "materialcommunityicons",
    "#ffffff",
    "#f21c1c"
  )
];