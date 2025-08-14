import 'package:easy_world_vendor/models/payout_details.dart';
import 'package:easy_world_vendor/repo/payout/get_payout_details_repo.dart';
import 'package:easy_world_vendor/repo/payout/request_payout_repo.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class PayoutController extends GetxController {
  var isLoading = false.obs;
  RxList<PayoutDetails> payoutList = <PayoutDetails>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllPayouts();
  }

  getAllPayouts() async {
    isLoading.value = true;
    await GetPayoutDetailsRepo.getPayoutDetailsRepo(
      onSuccess: (payouts) {
        payoutList.assignAll(payouts);
        isLoading.value = false;
      },
      onError: (msg) {
        isLoading.value = false;
        CustomSnackBar.error(title: "Payout", message: msg);
      },
    );
  }

  final GlobalKey<FormState> payoutFormKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final loading = SimpleFontelicoProgressDialog(
    context: Get.context!,
    barrierDimisable: false,
  );
  void requestPayout() {
    if (payoutFormKey.currentState!.validate()) {
      loading.show(message: 'Loading...');
      RequestPayoutRepo.requestPayoutRepo(
        amount: amountController.text,
        onSuccess: (message) async {
          loading.hide();

          await getAllPayouts();
          CustomSnackBar.success(title: "Payout", message: message);
          amountController.clear();
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Payout", message: message);
        },
      );
    } else {
      CustomSnackBar.error(
        title: "Payout",
        message: "Please fill in all fields correctly.",
      );
    }
  }
}
