import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  var selectedTabIndex = 0.obs;
  final List<String> tabs = ["Weekly", "Monthly", "Yearly"];

  final List<List<double>> chartData = [
    [1200, 1400, 1300, 1250, 1100, 1150, 1180],
    [4800, 3000, 5000, 5300, 5500, 5700, 5600, 5800, 5900, 6000, 2000, 6200],
    [60000, 62000, 64000, 65000, 67000, 68000],
  ];

  final List<List<String>> bottomLabels = [
    ["Sun", "Mon", "Tue", "Wed", "thu", "Fri", "Sat"],
    [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Set",
      "Oct",
      "Nov",
      "Dec",
    ],
    ["2025", "2026", "2027", "2028", "2029", "2030"],
  ];

  void updateTab(int index) {
    selectedTabIndex.value = index;
  }
}
