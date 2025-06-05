import 'package:easy_world_vendor/views/dashboard/products_reviews_screen.dart';
import 'package:easy_world_vendor/widgets/custom_review_widget.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:get/get.dart';

class ProductDescriptionScreen extends StatelessWidget {
  final bool isDark;
  const ProductDescriptionScreen({super.key, required this.isDark});

  final List<String> imageUrls = const [
    "https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg",
    "https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg",
    "https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg",
    "https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg",
    "https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg",
    "https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        backgroundColor:
            isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        iconTheme: IconThemeData(
          color: isDark ? AppColors.extraWhite : AppColors.blackColor,
        ),
        title: Text(
          "Product Details",
          style: CustomTextStyles.f16W600(
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Big main image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: imageUrls[0],
                width: double.infinity,
                height: 200,
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
                        (context, url, error) => Image.asset(ImagePath.noImage),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),
            Text(
              "Crochet Bear Keychain",
              style: CustomTextStyles.f18W700(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                priceInfo("Unit Price", "\$10.00", isDark),
                priceInfo("Purchase Price", "\$12.00", isDark),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              "Description",
              style: CustomTextStyles.f16W600(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "This handmade crochet bear keychain is the perfect accessory for your keys, bags, or as a heartfelt gift. Lovingly crafted with premium cotton yarn, it features a soft texture, charming design, and lasting durability. Each bear is carefully stitched to ensure quality and uniqueness, making it a thoughtful keepsake for any occasion.",
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
              "Brand: CozyLoops",
              style: CustomTextStyles.f14W400(
                color:
                    isDark
                        ? AppColors.extraWhite.withOpacity(0.7)
                        : AppColors.secondaryTextColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "SKU: BEAR-2025",
              style: CustomTextStyles.f14W400(
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
            const SizedBox(height: 8),
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
                      text: "8 May 2025 08:44 PM",
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
          style: CustomTextStyles.f14W400(
            color:
                isDark
                    ? AppColors.extraWhite.withOpacity(0.7)
                    : AppColors.secondaryTextColor,
          ),
        ),
        Text(
          price,
          style: CustomTextStyles.f16W700(
            color: isDark ? AppColors.primaryColor : AppColors.secondaryColor,
          ),
        ),
      ],
    );
  }
}
