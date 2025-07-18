import 'package:easy_world_vendor/controller/dashboard/products_screen_controller.dart';
import 'package:easy_world_vendor/models/reviews.dart';
import 'package:easy_world_vendor/views/dashboard/full_image_view_screen.dart';
import 'package:easy_world_vendor/views/dashboard/products_reviews_screen.dart';
import 'package:easy_world_vendor/widgets/custom_review_widget.dart';
import 'package:easy_world_vendor/widgets/product_dec_shimmer_widget.dart';
import 'package:easy_world_vendor/widgets/product_desc_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductDescriptionScreen extends StatelessWidget {
  final bool isDark;
  final String productId;
  ProductDescriptionScreen({
    super.key,
    required this.isDark,
    required this.productId,
  });
  final c = Get.put(ProductsScreenController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.fetchProductById(productId);
    });
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        backgroundColor:
            isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        iconTheme: IconThemeData(
          color: isDark ? AppColors.extraWhite : AppColors.blackColor,
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
        title: Text(
          "Product Details",
          style: CustomTextStyles.f16W600(
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
      ),
      body: Obx(() {
        if (c.isLoading.value) {
          return SingleChildScrollView(
            child: ProductDecShimmerWidget(isDark: isDark),
          );
        }
        final products = c.product.value;
        if (products == null) {
          return const Center(child: Text("Product not found"));
        }
        final List<String> imageUrls = products.productImages ?? [];

        return SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 4,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrls.isNotEmpty) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: imageUrls[0],
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) => Image.asset(ImagePath.noImage),
                  ),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  itemCount: imageUrls.length - 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => FullImageViewScreen(
                            imageUrl: imageUrls[index + 1],
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: imageUrls[index + 1],
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (context, url, error) =>
                                  Image.asset(ImagePath.noImage),
                        ),
                      ),
                    );
                  },
                ),
              ] else ...[
                Image.asset(ImagePath.noImage, height: 220, fit: BoxFit.cover),
              ],
              const SizedBox(height: 16),
              Text(
                products.name ?? "",
                style: CustomTextStyles.f18W700(
                  color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                ),
              ),
              const SizedBox(height: 8),
              PriceWidget(isDark: isDark, products: products),
              const SizedBox(height: 14),
              Text(
                "Description",
                style: CustomTextStyles.f14W600(
                  color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                products.description ?? "",
                style: CustomTextStyles.f12W400(
                  color:
                      isDark
                          ? AppColors.extraWhite.withOpacity(0.6)
                          : AppColors.secondaryTextColor,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 14),
              Text(
                "Brand: ${products.brand ?? ""}",
                style: CustomTextStyles.f12W400(
                  color:
                      isDark
                          ? AppColors.extraWhite.withOpacity(0.7)
                          : AppColors.secondaryTextColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "SKU: ${products.sku ?? ""}",
                style: CustomTextStyles.f12W400(
                  color:
                      isDark
                          ? AppColors.extraWhite.withOpacity(0.7)
                          : AppColors.secondaryTextColor,
                ),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Customer Reviews",
                    style: CustomTextStyles.f14W600(
                      color:
                          isDark ? AppColors.extraWhite : AppColors.blackColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        () => ProductsReviewsScreen(
                          productId: products.id.toString(),
                        ),
                      );
                    },
                    child: Text(
                      "View All",
                      style: CustomTextStyles.f12W400(
                        color:
                            isDark
                                ? AppColors.primaryColor
                                : AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<Reviews>>(
                future: c.getAllReviewsByProductId(products.id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ReviewShimmerWidget(isDark: isDark);
                  } else if (snapshot.hasError ||
                      snapshot.data == null ||
                      snapshot.data!.isEmpty) {
                    return SizedBox(
                      height: 60,
                      child: Center(
                        child: Text(
                          "No review",
                          style: CustomTextStyles.f12W400(
                            color: AppColors.secondaryTextColor,
                          ),
                        ),
                      ),
                    );
                  } else {
                    final List<Reviews> reviews = snapshot.data!;
                    return Column(
                      children:
                          reviews.map((review) {
                            return ReviewBox(isDark: isDark, reviews: review);
                          }).toList(),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Created at: ",
                        style: CustomTextStyles.f12W400(
                          color:
                              isDark
                                  ? AppColors.extraWhite.withOpacity(0.5)
                                  : AppColors.secondaryTextColor.withOpacity(
                                    0.7,
                                  ),
                        ),
                      ),
                      TextSpan(
                        text:
                            products.createdAt != null &&
                                    products.createdAt!.isNotEmpty
                                ? DateFormat('d MMM yyyy hh:mm a').format(
                                  DateTime.parse(products.createdAt!).toLocal(),
                                )
                                : '',
                        style: CustomTextStyles.f12W400(
                          color:
                              isDark
                                  ? AppColors.primaryColor.withOpacity(0.7)
                                  : AppColors.secondaryColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
