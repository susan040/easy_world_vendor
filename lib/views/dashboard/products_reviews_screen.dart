import 'package:easy_world_vendor/controller/dashboard/products_screen_controller.dart';
import 'package:easy_world_vendor/models/reviews.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/widgets/custom_review_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsReviewsScreen extends StatelessWidget {
  final controller = Get.put(ProductsScreenController());
  ProductsReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final avgRating = controller.calculateAverageRating(
      controller.allReviewsLists,
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "All Reviews",
          style: CustomTextStyles.f16W600(
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Overall Rating',
                  style: CustomTextStyles.f14W600(
                    color:
                        isDark
                            ? AppColors.extraWhite.withOpacity(0.6)
                            : AppColors.secondaryTextColor,
                  ),
                ),
                Text(
                  avgRating.toStringAsFixed(1),
                  style: CustomTextStyles.f32W600(
                    color:
                        isDark
                            ? AppColors.primaryColor
                            : AppColors.secondaryColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Icon(
                      index < avgRating ? Icons.star : Icons.star_border,
                      color: Colors.amber.shade700,
                      size: 24,
                    );
                  }),
                ),
                const SizedBox(height: 6),
                Text(
                  'Total Review: ${controller.allReviewsLists.length} reviews',
                  style: CustomTextStyles.f14W400(
                    color:
                        isDark
                            ? AppColors.extraWhite.withOpacity(0.6)
                            : AppColors.secondaryTextColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Obx(
              () =>
                  controller.isLoading.value
                      ? SizedBox(
                        height: 100,
                        child: const Center(child: CircularProgressIndicator()),
                      )
                      : controller.allProductLists.isEmpty
                      ? SizedBox(
                        height: 100,
                        child: Center(
                          child: Text(
                            "No reviews",
                            style: CustomTextStyles.f14W400(
                              color: AppColors.textGreyColor,
                            ),
                          ),
                        ),
                      )
                      : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.allReviewsLists.length,
                        itemBuilder: (context, index) {
                          final Reviews reviews =
                              controller.allReviewsLists[index];
                          return ReviewBox(isDark: isDark, reviews: reviews);
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
