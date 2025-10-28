import 'package:easy_world_vendor/controller/dashboard/order_screen_controller.dart';
import 'package:easy_world_vendor/repo/add_tracking_id_repo.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class SellerOrderTrackingController extends GetxController {
  final String orderNo;
  final int orderId;
  final RxInt currentIndex = 0.obs;
  var orderTrackingId = ''.obs;
  final RxString currentStatus = ''.obs;
  final trackingIdController = TextEditingController();
  final List<TrackingStep> steps = [];
  final OrderScreenController orderController =
      Get.find<OrderScreenController>();
  @override
  void onInit() {
    super.onInit();
  }

  SellerOrderTrackingController(
    this.orderNo,
    String initialStatus,
    this.orderId,
    String trackingIdFromOrder,
  ) {
    this.orderTrackingId.value = trackingIdFromOrder;
    Color getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case 'order placed':
          return AppColors.skyBlue;
        case 'paid':
          return AppColors.lightGreen;
        case 'packed':
          return AppColors.lightblue;
        case 'shipped':
          return AppColors.darkblue;
        case 'delivered':
          return AppColors.accepted;
        case 'cancelled':
          return AppColors.redColor;
        default:
          return AppColors.secondaryTextColor;
      }
    }

    steps.addAll([
      TrackingStep(
        title: 'Order Placed',
        description: 'Customer has placed the order.',
        icon: Icons.shopping_cart,
        color: getStatusColor('order placed'),
      ),
      TrackingStep(
        title: 'Paid',
        description: 'Payment has been received.',
        icon: Icons.payment,
        color: getStatusColor('paid'),
      ),
      TrackingStep(
        title: 'Packed',
        description: 'Order has been packed and ready to ship.',
        icon: Icons.inventory_2_outlined,
        color: getStatusColor('packed'),
      ),
      TrackingStep(
        title: 'Shipped',
        description: 'Order shipped to customer.',
        icon: Icons.local_shipping,
        color: getStatusColor('shipped'),
      ),
      TrackingStep(
        title: 'Delivered',
        description: 'Order delivered to customer.',
        icon: Icons.check_circle_outline,
        color: getStatusColor('delivered'),
      ),
    ]);

    int index = steps.indexWhere(
      (step) => step.title.toLowerCase() == initialStatus.toLowerCase(),
    );
    currentIndex.value = index == -1 ? 0 : index;
    final order = orderController.allOrderLists.firstWhere(
      (o) => o.id == orderId,
      orElse: () => orderController.allOrderLists.first,
    );
    currentStatus.value = order.status?.toLowerCase() ?? '';
  }
  void updateStatus(BuildContext context, bool isDark) async {
    if (currentIndex.value >= steps.length - 1) return;

    final nextStep = steps[currentIndex.value + 1].title.toLowerCase();
    if (nextStep == 'shipped') {
      TextEditingController trackingController = TextEditingController();

      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: isDark ? AppColors.darkModeColor : Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 14,
              top: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Enter Tracking ID',
                  style: CustomTextStyles.f14W600(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 65,
                  child: CustomTextField(
                    controller: trackingController,
                    hint: "Tracking ID",
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.number,
                  ),
                ),

                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      final id = trackingController.text.trim();
                      if (id.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Please enter a tracking ID.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }

                      Navigator.pop(context);

                      orderTrackingId.value = id;
                      await addTrackingId(id);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Confirm',
                      style: CustomTextStyles.f13W600(
                        color: AppColors.extraWhite,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      );
      if (trackingController.text.trim().isEmpty) return;
    }
    currentIndex.value++;
    orderController.changeStatus(
      orderId.toString(),
      steps[currentIndex.value].title.toLowerCase(),
    );
    currentStatus.value = steps[currentIndex.value].title.toLowerCase();
  }

  Future<void> addTrackingId(String id) async {
    final loading = SimpleFontelicoProgressDialog(
      context: Get.context!,
      barrierDimisable: false,
    );
    loading.show(message: 'Adding Tracking ID...');

    await AddTrackingIdRepo.addTrackingIdRepo(
      orderId: orderId.toString(),
      trackingId: id,
      onSuccess: (message) async {
        loading.hide();
        this.orderTrackingId.value = id;
        CustomSnackBar.success(title: "Tracking ID", message: message);
      },
      onError: (message) {
        loading.hide();
        CustomSnackBar.error(title: "Tracking ID", message: message);
      },
    );
  }

  void openLink(String trackingId) async {
    final Uri url = Uri.parse(
      "https://www.fedex.com/fedextrack/?tracknumbers=$trackingId",
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}

class TrackingStep {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  TrackingStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
