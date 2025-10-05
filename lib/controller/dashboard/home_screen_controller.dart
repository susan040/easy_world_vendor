import 'dart:developer';

import 'package:easy_world_vendor/models/earning_details.dart';
import 'package:easy_world_vendor/repo/get_earning_details_repo.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  Rxn<EarningDetails> earningDetails = Rxn<EarningDetails>();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEarnings();
  }

  void fetchEarnings() {
    isLoading.value = true;
    GetEarningDetailsRepo.getEarningDetailsRepo(
      onSuccess: (data) {
        earningDetails.value = data;
        isLoading.value = false;
      },
      onError: (message) {
        isLoading.value = false;
        // Get.snackbar("Error", message);
        log("Error fetching earnings: $message");
      },
    );
  }

  var selectedTabIndex = 0.obs;
  final List<String> tabs = ["Weekly", "Monthly", "Yearly"];

  void updateTab(int index) {
    selectedTabIndex.value = index;
  }

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

  var chartTypeIndex = 0.obs;

  void updateChartType(int index) {
    chartTypeIndex.value = index;
  }

  var touchedIndex = RxnInt(null);

  void updateTouchedIndex(int? index) {
    touchedIndex.value = index;
  }
}
