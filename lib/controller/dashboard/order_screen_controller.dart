import 'package:easy_world_vendor/models/orders.dart';
import 'package:easy_world_vendor/repo/delete_order_repo.dart';
import 'package:easy_world_vendor/repo/get_order_repo.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
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

  deleteOrder(int orderId) async {
    isLoading.value = true;
    await DeleteOrderRepo.deleteOrderRepo(
      orderId: orderId,
      onSuccess: (message) {
        isLoading.value = false;
        allOrderLists.removeWhere((order) => order.id == orderId);
        update();
        CustomSnackBar.success(title: "Order", message: message);
      },
      onError: ((message) {
        isLoading.value = false;
        CustomSnackBar.error(title: "Order", message: message);
      }),
    );
  }
}
