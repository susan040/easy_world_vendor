import 'package:easy_world_vendor/models/products.dart';
import 'package:easy_world_vendor/views/dashboard/products_reviews_screen.dart';
import 'package:easy_world_vendor/widgets/custom_review_widget.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductDescriptionScreen extends StatelessWidget {
  final bool isDark;
  final Data products;
  ProductDescriptionScreen({
    super.key,
    required this.isDark,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = products.productImages ?? [];
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 16),
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
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: imageUrls[index + 1],
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                      errorWidget:
                          (context, url, error) =>
                              Image.asset(ImagePath.noImage),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                priceInfo(
                  "Unit Price",
                  "\$${products.costPrice ?? ""}",
                  isDark,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: priceInfo(
                    "Purchase Price",
                    "\$${products.price ?? ""}",
                    isDark,
                  ),
                ),
              ],
            ),
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
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => ProductsReviewsScreen());
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
            ReviewBox(
              name: "Emily",
              review:
                  "Very cute! The quality is amazing and it arrived quickly.",
              isDark: isDark,
              rating: 5,
              photos: [
                "https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg",
                "https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg",
              ],
            ),
            ReviewBox(
              name: "Liam",
              review: "Bought this as a gift for my sister and she loved it!",
              isDark: isDark,
              rating: 4,
              photos: [
                "https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg",
                "https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg",
                "https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg",
              ],
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
                                : AppColors.secondaryTextColor.withOpacity(0.7),
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
      ),
    );
  }

  Widget priceInfo(String label, String price, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: CustomTextStyles.f12W400(
            color:
                isDark
                    ? AppColors.extraWhite.withOpacity(0.7)
                    : AppColors.secondaryTextColor,
          ),
        ),
        Text(
          price,
          style: CustomTextStyles.f14W700(
            color: isDark ? AppColors.primaryColor : AppColors.secondaryColor,
          ),
        ),
      ],
    );
  }
}
