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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
          padding: EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
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
                  height: 115,
                  width: 103,
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
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: products.productImages!.first,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        placeholder:
                            (context, url) =>
                                Center(child: CircularProgressIndicator()),
                        errorWidget:
                            (context, url, error) => Image.asset(
                              ImagePath.noImage,
                              fit: BoxFit.cover,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 190,
                    child: Text(
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
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Brand: ${products.brand ?? ""}",
                    style: CustomTextStyles.f11W400(
                      color:
                          isDark
                              ? AppColors.extraWhite.withOpacity(0.7)
                              : AppColors.secondaryTextColor,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Unit Price",
                            style: CustomTextStyles.f11W400(
                              color:
                                  isDark
                                      ? AppColors.extraWhite.withOpacity(0.7)
                                      : AppColors.secondaryTextColor,
                            ),
                          ),
                          Obx(() {
                            final convertedPrice = exchangeRateController
                                .convertPriceFromAUD(products.costPrice)
                                .toStringAsFixed(2);
                            final code =
                                exchangeRateController
                                    .selectedCountryData['code'];
                            final symbol = code == 'NPR' ? 'Rs.' : '\$';
                            return Text(
                              "$symbol$convertedPrice",
                              style: CustomTextStyles.f12W700(
                                color:
                                    isDark
                                        ? AppColors.primaryColor
                                        : AppColors.secondaryColor,
                              ),
                            );
                          }),
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Purchase Price",
                            style: CustomTextStyles.f11W400(
                              color:
                                  isDark
                                      ? AppColors.extraWhite.withOpacity(0.7)
                                      : AppColors.secondaryTextColor,
                            ),
                          ),
                          Obx(() {
                            final convertedPrice = exchangeRateController
                                .convertPriceFromAUD(products.price)
                                .toStringAsFixed(2);
                            final code =
                                exchangeRateController
                                    .selectedCountryData['code'];
                            final symbol = code == 'NPR' ? 'Rs.' : '\$';
                            return Text(
                              "$symbol$convertedPrice",
                              style: CustomTextStyles.f12W700(
                                color:
                                    isDark
                                        ? AppColors.primaryColor
                                        : AppColors.secondaryColor,
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 170,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Created at: ",
                                style: CustomTextStyles.f11W400(
                                  color:
                                      isDark
                                          ? AppColors.extraWhite.withOpacity(
                                            0.7,
                                          )
                                          : AppColors.secondaryTextColor,
                                ),
                              ),
                              TextSpan(
                                text:
                                    products.createdAt != null &&
                                            products.createdAt!.isNotEmpty
                                        ? DateFormat(
                                          'd MMM yyyy hh:mm a',
                                        ).format(
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
