import 'package:easy_world_vendor/controller/dashboard/products_screen_controller.dart';
import 'package:easy_world_vendor/models/reviews.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/widgets/custom_review_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductsReviewsScreen extends StatelessWidget {
  final controller = Get.put(ProductsScreenController());
  ProductsReviewsScreen({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<List<Reviews>>(
            future: controller.getAllReviewsByProductId(productId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    child: Shimmer.fromColors(
                      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                      highlightColor:
                          isDark ? Colors.grey[700]! : Colors.grey[100]!,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 100,
                              margin: const EdgeInsets.only(bottom: 8, top: 8),
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 55,
                              margin: const EdgeInsets.only(bottom: 8),
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 120,
                              margin: const EdgeInsets.only(bottom: 8),
                              height: 25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 145,
                              margin: const EdgeInsets.only(bottom: 16),
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          Column(
                            children: List.generate(4, (index) {
                              return Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 12),
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError ||
                  snapshot.data == null ||
                  snapshot.data!.isEmpty) {
                return SizedBox(
                  height: Get.height / 1.3,
                  child: Center(
                    child: Text(
                      "No review",
                      style: CustomTextStyles.f14W400(
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ),
                );
              } else {
                final List<Reviews> reviews = snapshot.data!;
                controller.allReviewsLists.assignAll(reviews);
                final double avgRating = controller.calculateAverageRating(
                  reviews,
                );

                return Column(
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
                              index < avgRating
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber.shade700,
                              size: 24,
                            );
                          }),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Total Review: ${reviews.length} reviews',
                          style: CustomTextStyles.f14W400(
                            color:
                                isDark
                                    ? AppColors.extraWhite.withOpacity(0.6)
                                    : AppColors.secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    ...reviews
                        .map(
                          (review) => Padding(
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            child: ReviewBox(isDark: isDark, reviews: review),
                          ),
                        )
                        .toList(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
