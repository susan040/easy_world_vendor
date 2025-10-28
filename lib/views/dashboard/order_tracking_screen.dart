import 'package:easy_world_vendor/controller/dashboard/seller_order_tracking_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SellerOrderTrackingScreen extends StatelessWidget {
  final String orderNo;
  final String currentStatus;
  final String trackingId;
  final int orderId;

  const SellerOrderTrackingScreen({
    super.key,
    required this.orderNo,
    required this.currentStatus,
    required this.orderId,
    required this.trackingId,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = Get.put(
      SellerOrderTrackingController(
        orderNo,
        currentStatus,
        orderId,
        trackingId,
      ),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              top: 4,
              bottom: 18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        "Order No: $orderNo",
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
                Obx(() {
                  final steps = controller.steps;
                  final currentIndex = controller.currentIndex.value;

                  return ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
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
                                    style: CustomTextStyles.f12W400(
                                      color:
                                          isDark
                                              ? Colors.grey.shade500
                                              : Colors.grey.shade600,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Obx(() {
                                    final id = controller.orderTrackingId.value;

                                    if (index == 3 && id.isNotEmpty) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Clipboard.setData(
                                                  ClipboardData(text: id),
                                                );
                                                Get.snackbar(
                                                  "Copied",
                                                  "Tracking ID copied",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Tracking ID: $id',
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  const Icon(
                                                    Icons.copy,
                                                    size: 14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            GestureDetector(
                                              onTap:
                                                  () => controller.openLink(id),
                                              child: const Text(
                                                'Track on FedEx',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: AppColors.primaryColor,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
          child: Obx(() {
            final currentIndex = controller.currentIndex.value;
            return currentIndex < controller.steps.length - 1
                ? SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () => controller.updateStatus(context, isDark),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Mark as ${controller.steps[currentIndex + 1].title}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
                : const SizedBox.shrink();
          }),
        ),
      ),
    );
  }
}
