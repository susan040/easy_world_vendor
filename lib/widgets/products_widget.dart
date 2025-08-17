import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_world_vendor/controller/dashboard/exchange_rate_controller.dart';
import 'package:easy_world_vendor/models/products.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:easy_world_vendor/views/dashboard/product_description_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductsWidget extends StatelessWidget {
  ProductsWidget({super.key, required this.isDark, required this.products});
  final bool isDark;
  final Data products;
  final exchangeRateController = Get.put(ExchangeRateController());

  @override
  Widget build(BuildContext context) {
    double price = double.tryParse(products.price ?? "0") ?? 0;
    double discount = double.tryParse(products.discount ?? "0") ?? 0;
    double discountPercent =
        products.discountType == "percentage"
            ? discount
            : (price > 0 ? (discount / price) * 100 : 0);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          Get.to(
            () => ProductDescriptionScreen(
              isDark: isDark,
              productId: products.id.toString(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          width: double.infinity,
          decoration: BoxDecoration(
            color:
                isDark
                    ? AppColors.blackColor.withOpacity(0.3)
                    : AppColors.extraWhite,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.transparent : AppColors.lGrey,
                blurRadius: 1.5,
                spreadRadius: 2.5,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 106,
                  width: 90,
                  decoration: BoxDecoration(
                    color: AppColors.extraWhite,
                    boxShadow: [
                      BoxShadow(
                        color:
                            isDark ? AppColors.darkModeColor : AppColors.lGrey,
                        spreadRadius: 1,
                        blurRadius: 1.5,
                      ),
                    ],
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        products.productImages!.isNotEmpty
                            ? products.productImages!.first
                            : "",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) =>
                            Image.asset(ImagePath.noImage, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      products.name ?? "",
                      style: CustomTextStyles.f12W600(
                        color:
                            isDark
                                ? AppColors.extraWhite
                                : AppColors.blackColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Brand: ${products.brand ?? ""}",
                      style: CustomTextStyles.f11W400(
                        color:
                            isDark
                                ? AppColors.extraWhite.withOpacity(0.7)
                                : AppColors.secondaryTextColor,
                      ),
                    ),
                    // if (products.category?.categoryName != null &&
                    //     products.category!.categoryName!.isNotEmpty)
                    //   Text(
                    //     "Category: ${products.category!.categoryName!}",
                    //     style: CustomTextStyles.f11W400(
                    //       color:
                    //           isDark
                    //               ? AppColors.extraWhite.withOpacity(0.7)
                    //               : AppColors.secondaryTextColor,
                    //     ),
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Obx(() {
                          final convertedPrice = exchangeRateController
                              .convertPriceFromAUD(
                                products.discountTotalAmount ?? "0",
                              )
                              .toStringAsFixed(2);
                          final code =
                              exchangeRateController
                                  .selectedCountryData['code'];
                          final symbol = code == 'NPR' ? 'Rs.' : '\$';
                          return Text(
                            "$symbol$convertedPrice",
                            style: CustomTextStyles.f14W700(
                              color:
                                  isDark
                                      ? AppColors.primaryColor
                                      : AppColors.secondaryColor,
                            ),
                          );
                        }),
                        const SizedBox(width: 6),

                        if (products.discount != null &&
                            products.discountType != null &&
                            products.discountTotalAmount != null)
                          Row(
                            children: [
                              Obx(() {
                                final convertedPrice = exchangeRateController
                                    .convertPriceFromAUD(products.price ?? "0")
                                    .toStringAsFixed(2);
                                final code =
                                    exchangeRateController
                                        .selectedCountryData['code'];
                                final symbol = code == 'NPR' ? 'Rs.' : '\$';
                                return Text(
                                  "$symbol$convertedPrice",
                                  style: const TextStyle(
                                    color: AppColors.textGreyColor,
                                    fontSize: 12,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                );
                              }),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 3,
                                  right: 3,
                                  top: 1,
                                  bottom: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.rejected,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Center(
                                  child: Text(
                                    "-${discountPercent.toStringAsFixed(0)}%",
                                    style: CustomTextStyles.f10W400(
                                      color: AppColors.extraWhite,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Status",
                              style: CustomTextStyles.f11W400(
                                color:
                                    isDark
                                        ? AppColors.hintTextColor
                                        : AppColors.secondaryTextColor,
                              ),
                            ),
                            Text(
                              products.isActive == true ? "Active" : "Inactive",
                              style: CustomTextStyles.f11W600(
                                color:
                                    products.isActive == true
                                        ? AppColors.accepted
                                        : Colors.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Created at:",
                              style: CustomTextStyles.f11W400(
                                color:
                                    isDark
                                        ? AppColors.hintTextColor
                                        : AppColors.secondaryTextColor,
                              ),
                            ),
                            Text(
                              products.createdAt != null &&
                                      products.createdAt!.isNotEmpty
                                  ? DateFormat('d MMM yyyy hh:mm a').format(
                                    DateTime.parse(
                                      products.createdAt!,
                                    ).toLocal(),
                                  )
                                  : '',
                              style: CustomTextStyles.f11W400(
                                color:
                                    isDark
                                        ? AppColors.primaryColor
                                        : AppColors.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
