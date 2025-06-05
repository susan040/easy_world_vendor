import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:easy_world_vendor/views/dashboard/product_description_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key, required this.isDark});
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Get.to(() => ProductDescriptionScreen(isDark: isDark));
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
                  height: 111,
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
                        imageUrl:
                            "https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg",
                        fit: BoxFit.fill,
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
                  Text(
                    "Crochet Bear Keychain ",
                    style: CustomTextStyles.f14W600(
                      color:
                          isDark ? AppColors.extraWhite : AppColors.blackColor,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Hand made > Key chain",
                    style: CustomTextStyles.f12W400(
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
                            style: CustomTextStyles.f12W400(
                              color:
                                  isDark
                                      ? AppColors.extraWhite.withOpacity(0.7)
                                      : AppColors.secondaryTextColor,
                            ),
                          ),
                          Text(
                            "\$10.00",
                            style: CustomTextStyles.f16W700(
                              color:
                                  isDark
                                      ? AppColors.primaryColor
                                      : AppColors.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Purchase Price",
                            style: CustomTextStyles.f12W400(
                              color:
                                  isDark
                                      ? AppColors.extraWhite.withOpacity(0.7)
                                      : AppColors.secondaryTextColor,
                            ),
                          ),
                          Text(
                            "\$12.00",
                            style: CustomTextStyles.f16W700(
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
                                style: CustomTextStyles.f12W400(
                                  color:
                                      isDark
                                          ? AppColors.extraWhite.withOpacity(
                                            0.7,
                                          )
                                          : AppColors.secondaryTextColor,
                                ),
                              ),
                              TextSpan(
                                text: "8 May 2025 08:44 PM",
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
