import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerOrderTrackingScreen extends StatelessWidget {
  final String orderNo;
  final String currentStatus;

  const SellerOrderTrackingScreen({
    super.key,
    required this.orderNo,
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = Get.put(
      SellerOrderTrackingController(orderNo, currentStatus),
    );

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Order Tracking",
          style: CustomTextStyles.f16W600(
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order number section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:
                      isDark
                          ? Colors.white.withOpacity(0.05)
                          : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.receipt_long,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Order No: #$orderNo",
                      style: CustomTextStyles.f14W500(
                        color:
                            isDark
                                ? AppColors.extraWhite
                                : AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Tracking steps
              Expanded(
                child: Obx(() {
                  final steps = controller.steps;
                  final currentIndex = controller.currentIndex.value;

                  return ListView.separated(
                    itemCount: steps.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final step = steps[index];
                      final isCompleted = index <= currentIndex;
                      final isLast = index == steps.length - 1;

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor:
                                    isCompleted
                                        ? AppColors.primaryColor
                                        : (isDark
                                            ? AppColors.secondaryTextColor
                                                .withOpacity(0.9)
                                            : AppColors.secondaryTextColor
                                                .withOpacity(0.3)),
                                child:
                                    isCompleted
                                        ? const Icon(
                                          Icons.check,
                                          size: 14,
                                          color: Colors.white,
                                        )
                                        : null,
                              ),
                              if (!isLast)
                                Container(
                                  width: 2,
                                  height: 50,
                                  color:
                                      isCompleted
                                          ? AppColors.primaryColor
                                          : (isDark
                                              ? AppColors.secondaryTextColor
                                                  .withOpacity(0.9)
                                              : AppColors.secondaryTextColor
                                                  .withOpacity(0.3)),
                                ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    isCompleted
                                        ? AppColors.primaryColor.withOpacity(
                                          0.05,
                                        )
                                        : (isDark
                                            ? Colors.white.withOpacity(0.03)
                                            : Colors.grey.shade100),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        step.icon,
                                        size: 20,
                                        color:
                                            isCompleted
                                                ? step.color
                                                : (isDark
                                                    ? AppColors.grey
                                                        .withOpacity(0.6)
                                                    : AppColors
                                                        .secondaryTextColor),
                                      ),
                                      const SizedBox(width: 6),

                                      Text(
                                        step.title,
                                        style: CustomTextStyles.f14W600(
                                          color:
                                              isCompleted
                                                  ? step.color
                                                  : (isDark
                                                      ? AppColors.grey
                                                          .withOpacity(0.6)
                                                      : AppColors
                                                          .secondaryTextColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    step.description,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color:
                                          isDark
                                              ? Colors.grey.shade400
                                              : Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
              ),

              // Action button
              Obx(() {
                final currentIndex = controller.currentIndex.value;
                return currentIndex < controller.steps.length - 1
                    ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: controller.updateStatus,
                        child: Text(
                          'Mark as ${controller.steps[currentIndex + 1].title}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                    : const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// Controller remains same as yours but UI-only (no API)
class SellerOrderTrackingController extends GetxController {
  final String orderNo;
  final RxInt currentIndex = 0.obs;
  late final List<_TrackingStep> steps;

  SellerOrderTrackingController(this.orderNo, String initialStatus) {
    Color getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case 'pending':
          return AppColors.yellow;
        case 'paid':
          return AppColors.skyBlue;
        case 'packed':
          return AppColors.lightblue;
        case 'in transit':
        case 'shipped': // adding shipped as it matches your step title
          return AppColors.darkblue;
        case 'delivered':
          return AppColors.accepted;
        case 'cancelled':
          return AppColors.redColor;
        case 'paypal':
          return AppColors.lightGreen;
        case 'order received': // added to handle your first step
          return AppColors.skyBlue; // you can customize this
        case 'preparing': // for preparing step color
          return AppColors.yellow;
        default:
          return AppColors.secondaryTextColor;
      }
    }

    steps = [
      _TrackingStep(
        title: 'Order Received',
        description: 'You have received a new order.',
        icon: Icons.assignment_turned_in,
        color: getStatusColor('order received'),
      ),
      _TrackingStep(
        title: 'Preparing',
        description: 'Preparing the order for shipment.',
        icon: Icons.kitchen,
        color: getStatusColor('preparing'),
      ),
      _TrackingStep(
        title: 'Packed',
        description: 'Order has been packed and ready to ship.',
        icon: Icons.inventory_2_outlined,
        color: getStatusColor('packed'),
      ),
      _TrackingStep(
        title: 'Shipped',
        description: 'Order shipped to customer.',
        icon: Icons.local_shipping,
        color: getStatusColor('shipped'),
      ),
      _TrackingStep(
        title: 'Delivered',
        description: 'Order delivered to customer.',
        icon: Icons.check_circle_outline,
        color: getStatusColor('delivered'),
      ),
    ];

    int index = steps.indexWhere(
      (step) => step.title.toLowerCase() == initialStatus.toLowerCase(),
    );
    currentIndex.value = index == -1 ? 0 : index;
  }

  void updateStatus() {
    if (currentIndex.value < steps.length - 1) {
      currentIndex.value++;
    }
  }
}

class _TrackingStep {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  _TrackingStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
