import 'package:easy_world_vendor/controller/dashboard/exchange_rate_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/products_screen_controller.dart';
import 'package:easy_world_vendor/models/reviews.dart';
import 'package:easy_world_vendor/views/dashboard/full_image_view_screen.dart';
import 'package:easy_world_vendor/views/dashboard/products_reviews_screen.dart';
import 'package:easy_world_vendor/widgets/custom_review_widget.dart';
import 'package:easy_world_vendor/widgets/product_dec_shimmer_widget.dart';
import 'package:easy_world_vendor/widgets/product_desc_widget.dart';
import 'package:easy_world_vendor/widgets/product_price_calculation_widget.dart';
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
  final exchangeRateController = Get.put(ExchangeRateController());

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
      body: SafeArea(
        child: Obx(() {
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
          double price = double.tryParse(products.price ?? "0") ?? 0;
          double discount = double.tryParse(products.discount ?? "0") ?? 0;
          double discountPercent =
              products.discountType == "percentage"
                  ? discount
                  : (price > 0 ? (discount / price) * 100 : 0);
          final int quantity =
              int.tryParse(products.quantity?.toString() ?? '0') ?? 0;
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Image
                if (imageUrls.isNotEmpty)
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
                          (context, url, error) =>
                              Image.asset(ImagePath.noImage),
                    ),
                  )
                else
                  Image.asset(
                    ImagePath.noImage,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(height: 12),

                // Gallery Thumbnails
                if (imageUrls.length > 1)
                  GridView.builder(
                    itemCount: imageUrls.length - 1,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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

                const SizedBox(height: 16),

                Text(
                  products.name ?? "",
                  style: CustomTextStyles.f16W700(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                ProductPriceCalculationWidget(
                  products: products,
                  isDark: isDark,
                  quantity: quantity,
                  exchangeRateController: exchangeRateController,
                  discountPercent: discountPercent,
                ),

                ProductDetailsWidget(isDark: isDark, products: products),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Customer Reviews",
                      style: CustomTextStyles.f14W600(
                        color:
                            isDark
                                ? AppColors.extraWhite
                                : AppColors.blackColor,
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
                        style: CustomTextStyles.f13W400(
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

                // Reviews List
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
                            style: CustomTextStyles.f13W400(
                              color: AppColors.secondaryTextColor,
                            ),
                          ),
                        ),
                      );
                    } else {
                      final List<Reviews> reviews = snapshot.data!;
                      return Column(
                        children:
                            reviews
                                .map(
                                  (review) => ReviewBox(
                                    isDark: isDark,
                                    reviews: review,
                                  ),
                                )
                                .toList(),
                      );
                    }
                  },
                ),

                const SizedBox(height: 20),

                // Created At
                Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Created at: ",
                          style: CustomTextStyles.f13W400(
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
                                    DateTime.parse(
                                      products.createdAt!,
                                    ).toLocal(),
                                  )
                                  : '',
                          style: CustomTextStyles.f13W400(
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
      ),
    );
  }
}
