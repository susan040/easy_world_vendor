import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  var selectedTabIndex = 0.obs;

  final List<String> tabs = ["Revenue", "Units", "Profit"];

  final List<List<double>> chartData = [
    [600, 750, 900, 700, 900, 800, 920], // Revenue
    [500, 600, 850, 670, 850, 750, 800], // Units
    [400, 700, 800, 660, 820, 790, 850], // Profit
  ];
  final List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"];

  void updateTab(int index) {
    selectedTabIndex.value = index;
  }
}
