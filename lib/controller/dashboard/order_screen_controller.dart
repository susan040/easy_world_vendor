import 'package:easy_world_vendor/models/orders.dart';
import 'package:easy_world_vendor/repo/get_order_repo.dart';
import 'package:get/get.dart';

class OrderScreenController extends GetxController {
  RxList<Orders> allOrderLists = <Orders>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  getAllOrders() async {
    isLoading.value = true;
    await GetOrdersRepo.getOrdersRepo(
      onSuccess: (order) {
        allOrderLists.assignAll(order);
        isLoading.value = false;
      },
      onError: (msg) {
        isLoading.value = false;
        print("Error: $msg");
      },
    );
  }
}
