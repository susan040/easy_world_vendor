import 'package:easy_world_vendor/models/orders.dart';
import 'package:easy_world_vendor/repo/change_order_status_repo.dart';
import 'package:easy_world_vendor/repo/delete_order_repo.dart';
import 'package:easy_world_vendor/repo/get_order_repo.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class OrderScreenController extends GetxController {
  RxList<Orders> allOrderLists = <Orders>[].obs;
  RxList<Orders> filteredOrderLists = <Orders>[].obs;
  var isLoading = true.obs;
  DateTime? filterStartDate;
  DateTime? filterEndDate;
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
        allOrderLists.sort((a, b) {
          DateTime dateA = DateTime.parse(a.createdAt ?? '1970-01-01T00:00:00');
          DateTime dateB = DateTime.parse(b.createdAt ?? '1970-01-01T00:00:00');
          return dateB.compareTo(dateA);
        });

        applyCurrentFilter();
        isLoading.value = false;
      },
      onError: (msg) {
        isLoading.value = false;
        print("Error: $msg");
      },
    );
  }

  final loading = SimpleFontelicoProgressDialog(
    context: Get.context!,
    barrierDimisable: false,
  );
  deleteOrder(int orderId) async {
    isLoading.value = true;
    await DeleteOrderRepo.deleteOrderRepo(
      orderId: orderId,
      onSuccess: (message) {
        isLoading.value = false;
        allOrderLists.removeWhere((order) => order.id == orderId);
        filteredOrderLists.removeWhere((order) => order.id == orderId);
        getAllOrders();
        CustomSnackBar.success(title: "Order", message: message);
      },
      onError: ((message) {
        isLoading.value = false;
        CustomSnackBar.error(title: "Order", message: message);
      }),
    );
  }

  void changeStatus(String orderId, String status) async {
    loading.show(message: 'Loading...');
    await ChangeOrderStatusRepo.changeOrderStatusRepo(
      orderId: orderId,
      status: status,
      onSuccess: (message) {
        loading.hide();

        int index = allOrderLists.indexWhere((o) => o.id.toString() == orderId);
        int index1 = filteredOrderLists.indexWhere(
          (o) => o.id.toString() == orderId,
        );
        if (index != -1 && index1 != -1) {
          final updatedOrder = Orders.fromJson(allOrderLists[index].toJson());
          final updatedOrder1 = Orders.fromJson(
            filteredOrderLists[index1].toJson(),
          );
          updatedOrder1.status = status;
          updatedOrder.status = status;
          allOrderLists[index] = updatedOrder;
          filteredOrderLists[index1] = updatedOrder1;
          filteredOrderLists.refresh();
          allOrderLists.refresh();
        }
        CustomSnackBar.success(title: "Order", message: message);
      },
      onError: ((message) {
        loading.hide();
        CustomSnackBar.error(title: "Order", message: message);
      }),
    );
  }

  void applyCurrentFilter() {
    if (filterStartDate == null || filterEndDate == null) {
      filteredOrderLists.assignAll(allOrderLists);
      return;
    }

    filteredOrderLists.assignAll(
      allOrderLists.where((order) {
        final createdAt = DateTime.tryParse(order.createdAt ?? '');
        if (createdAt == null) return false;
        return createdAt.isAfter(
              filterStartDate!.subtract(const Duration(days: 1)),
            ) &&
            createdAt.isBefore(filterEndDate!.add(const Duration(days: 1)));
      }).toList(),
    );
  }

  void filterOrdersByDate(DateTime start, DateTime end) {
    filterStartDate = start;
    filterEndDate = end;
    applyCurrentFilter();
  }

  void clearDateFilter() {
    filterStartDate = null;
    filterEndDate = null;
    applyCurrentFilter();
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.yellow;
      case 'paid':
        return AppColors.skyBlue;
      case 'packed':
        return AppColors.lightblue;
      case 'in transit':
        return AppColors.darkblue;
      case 'delivered':
        return AppColors.accepted;
      case 'cancelled':
        return AppColors.redColor;
      default:
        return Colors.grey;
    }
  }

  String getOrderStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return "Payment pending on";
      case 'paid':
        return "Order is confirmed on";
      // case 'seller to pack':
      //   return "Seller will pack by";
      case 'packed':
        return "Order is packed on";
      case 'in transit':
        return "Order is in transit since";
      case 'delivered':
      case 'completed':
        return "Order is completed on";
      case 'cancelled':
        return "Order is cancelled on";
      default:
        return "Order status updated on";
    }
  }
}
