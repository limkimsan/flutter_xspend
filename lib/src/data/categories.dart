import 'package:flutter_xspend/src/constants/transaction_constant.dart';
import 'package:flutter_xspend/src/models/category.dart';

final categories = [
  Category()
    ..id = "2529fa6d-a529-44ce-8949-57275d179793"
    ..name = "Salary"
    ..nameKm = "ប្រាក់ខែ"
    ..transactionType = int.parse(transactionTypes['income']!['value'].toString())
    ..order = 1
    ..icon = "cash"
    ..iconType = "materialcommunityicons"
    ..iconColor = "#ffffff"
    ..bgColor = "#66CC00",
  Category()
    ..id = "50f5573b-cf95-4fef-9916-41d5ef2fd05e"
    ..name = "Returned fee"
    ..nameKm = "ប្រាក់សំណង"
    ..transactionType = int.parse(transactionTypes['income']!['value'].toString())
    ..order = 3
    ..icon = "refresh-ccw"
    ..iconType = "feather"
    ..iconColor = "#ffffff"
    ..bgColor = "#05c1ff",
  Category()
    ..id = "4e48297e-099c-4dcf-a620-31a7f398a36c"
    ..name = "Food"
    ..nameKm = "អាហារ"
    ..transactionType = int.parse(transactionTypes['expense']!['value'].toString())
    ..order = 1
    ..icon = "fast-food-outline"
    ..iconType = "ionicons"
    ..iconColor = "#000000"
    ..bgColor = "#FFA500",
  Category()
    ..id = "e95e4f02-a1b6-4c87-9d10-df03836ea490"
    ..name = "Drink"
    ..nameKm = "ភេសជ្ជៈ"
    ..transactionType = int.parse(transactionTypes['expense']!['value'].toString())
    ..order = 2
    ..icon = "coffee"
    ..iconType = "feather"
    ..iconColor = "#ffffff"
    ..bgColor = "#6f4e37",
  Category()
    ..id = "cc92ad4c-9d7b-42c3-8c83-9c9529466559"
    ..name = "Monthly fee"
    ..nameKm = "ការប្រាក់ប្រចាំ​ខែ"
    ..transactionType = int.parse(transactionTypes['income']!['value'].toString())
    ..order = 2
    ..icon = "cash-outline"
    ..iconType = "ionicons"
    ..iconColor = "#ffffff"
    ..bgColor = "#00a300",
  Category()
    ..id = "fe318f3f-0c6e-4c3d-a013-6b20cf719f03"
    ..name = "Gasoline"
    ..nameKm = "សាំង"
    ..transactionType = int.parse(transactionTypes['expense']!['value'].toString())
    ..order = 4
    ..icon = "gas-station-outline"
    ..iconType = "materialcommunityicons"
    ..iconColor = "#ffffff"
    ..bgColor = "#dc0404",
  Category()
    ..id = "99bc1b73-709b-4888-8cae-dd808f95bfa5"
    ..name = "Movie"
    ..nameKm = "ភាពយន្ត"
    ..transactionType = int.parse(transactionTypes['expense']!['value'].toString())
    ..order = 3
    ..icon = "film"
    ..iconType = "feather"
    ..iconColor = "#ffffff"
    ..bgColor = "#8b949c",
  Category()
    ..id = "52962d0f-0303-482d-bec1-859a6539fbd3"
    ..name = "Public service"
    ..nameKm = "សេវាសាធារណៈ"
    ..transactionType = int.parse(transactionTypes['expense']!['value'].toString())
    ..order = 5
    ..icon = "receipt-outline"
    ..iconType = "ionicons"
    ..iconColor = "#fdfcfc"
    ..bgColor = "#7a8ef0",
  Category()
    ..id = "dfb49315-e55d-4429-afe6-22196e0b738a"
    ..name = "Travel"
    ..nameKm = "ការធ្វើដំណើរ"
    ..transactionType = int.parse(transactionTypes['expense']!['value'].toString())
    ..order = 6
    ..icon = "car-outline"
    ..iconType = "ionicons"
    ..iconColor = "#fafafa"
    ..bgColor = "#406D5E",
  Category()
    ..id = "83b138e2-426c-4c8c-8532-5276362b91f0"
    ..name = "Accommodation"
    ..nameKm = "ការស្នាក់នៅ"
    ..transactionType = int.parse(transactionTypes['expense']!['value'].toString())
    ..order = 7
    ..icon = "bed-outline"
    ..iconType = "ionicons"
    ..iconColor = "#f7f7f7"
    ..bgColor = "#0071b8",
  Category()
    ..id = "3dcfaf97-75cb-4d48-8c55-6dbf88bbe053"
    ..name = "Electronic device"
    ..nameKm = "ឧបករណ៍អេឡិចត្រូនិក"
    ..transactionType = int.parse(transactionTypes['expense']!['value'].toString())
    ..order = 8
    ..icon = "cpu"
    ..iconType = "feather"
    ..iconColor = "#f7f7f7"
    ..bgColor = "#327DF5",
  Category()
    ..id = "dc071198-5bf2-4408-8cc5-cecb6256f2d3"
    ..name = "Health care"
    ..nameKm = "សេវាថែទាំសុខភាព"
    ..transactionType = int.parse(transactionTypes['expense']!['value'].toString())
    ..order = 9
    ..icon = "stethoscope"
    ..iconType = "fontawesome"
    ..iconColor = "#ffffff"
    ..bgColor = "#52cc00",
  Category()
    ..id = "cf12bacd-b5b4-4eca-8df2-3bae524e2160"
    ..name = "Online subscription"
    ..nameKm = "ការជាវអនឡាញ"
    ..transactionType = int.parse(transactionTypes['expense']!['value'].toString())
    ..order = 10
    ..icon = "web"
    ..iconType = "materialcommunityicons"
    ..iconColor = "#fcfcfc"
    ..bgColor = "#05e6d7",
  Category()
    ..id = "ada9772b-498f-4619-8962-7ad0c15ebca9"
    ..name = "Grocery"
    ..nameKm = "គ្រឿងទេស"
    ..transactionType = int.parse(transactionTypes['expense']!['value'].toString())
    ..order = 11
    ..icon = "shopping-cart"
    ..iconType = "feather"
    ..iconColor = "#ffffff"
    ..bgColor = "#49a300",
  Category()
    ..id = "97cb519e-2b22-45a5-a859-339cf83cef02"
    ..name = "Shopping"
    ..nameKm = "ទិញទំនិញ"
    ..transactionType = int.parse(transactionTypes['expense']!['value'].toString())
    ..order = 12
    ..icon = "shopping-bag"
    ..iconType = "feather"
    ..iconColor = "#ffffff"
    ..bgColor = "#a3a3a3",
  Category()
    ..id = "ebc67a95-64f8-4574-9c1d-6a96e0672f4a"
    ..name = "Trading"
    ..nameKm = "ការជួញដូរ"
    ..transactionType = int.parse(transactionTypes['income']!['value'].toString())
    ..order = 4
    ..icon = "swap-horizontal"
    ..iconType = "ionicons"
    ..iconColor = "#ffffff"
    ..bgColor = "#0030f0",
  Category()
    ..id = "b1540a66-be03-4bf8-9121-57c5b94cf7f7"
    ..name = "Utility"
    ..nameKm = "ទឹក និងភ្លើង"
    ..transactionType = int.parse(transactionTypes['expense']!['value'].toString())
    ..order = 13
    ..icon = "hammer-wrench"
    ..iconType = "materialcommunityicons"
    ..iconColor = "#ffffff"
    ..bgColor = "#14bdb2"
];