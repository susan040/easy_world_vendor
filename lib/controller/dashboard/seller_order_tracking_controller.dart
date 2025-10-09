import 'package:easy_world_vendor/controller/dashboard/order_screen_controller.dart';
import 'package:easy_world_vendor/repo/add_tracking_id_repo.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:easy_world_vendor/widgets/custom/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class SellerOrderTrackingController extends GetxController {
  final String orderNo;
  final int orderId;
  final RxInt currentIndex = 0.obs;
  final RxString trackingId = ''.obs;
  final RxString currentStatus = ''.obs;
  final trackingIdController = TextEditingController();
  final List<TrackingStep> steps = [];
  final OrderScreenController orderController =
      Get.find<OrderScreenController>();

  SellerOrderTrackingController(
    this.orderNo,
    String initialStatus,
    this.orderId,
  ) {
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
    trackingId.value = order.orderTrackingId ?? '';
  }
  void updateStatus(BuildContext context, bool isDark) async {
    if (currentIndex.value >= steps.length - 1) return;

    final nextStep = steps[currentIndex.value + 1].title.toLowerCase();

    String? id;
    if (nextStep == 'shipped') {
      id = await showTrackingIdDialog(context, isDark);
      if (id == null || id.isEmpty) return;
      //   trackingId.value = id; // Set reactive trackingId
    }

    // Update current index
    currentIndex.value++;

    // Update status on server
    orderController.changeStatus(
      orderId.toString(),
      steps[currentIndex.value].title.toLowerCase(),
    );

    // Update reactive status
    currentStatus.value = steps[currentIndex.value].title.toLowerCase();
  }

  /// Dialog to enter tracking ID
  Future<String?> showTrackingIdDialog(
    BuildContext context,
    bool isDark,
  ) async {
    final TextEditingController dialogController = TextEditingController();
    return await showDialog<String>(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor:
                isDark ? AppColors.darkModeColor : AppColors.extraWhite,
            title: Center(
              child: Text(
                "Enter FedEx Tracking ID",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                ),
              ),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 65,
              child: CustomTextField(
                controller: dialogController,
                hint: "Tracking ID",
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.text,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, null),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.rejected,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  addTrackingId(dialogController.text.trim());
                  final id = dialogController.text.trim();
                  if (id.isNotEmpty) Navigator.pop(context, id);
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 13,
                    color:
                        isDark
                            ? AppColors.primaryColor
                            : AppColors.secondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  /// Save tracking ID to server
  Future<void> addTrackingId(String id) async {
    final loading = SimpleFontelicoProgressDialog(
      context: Get.context!,
      barrierDimisable: false,
    );

    loading.show(message: 'Adding Tracking ID...');

    await AddTrackingIdRepo.addTrackingIdRepo(
      orderId: orderId.toString(),
      trackingId: id,
      onSuccess: (message) {
        loading.hide();
        CustomSnackBar.success(title: "Tracking ID", message: message);
        trackingIdController.clear();
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
