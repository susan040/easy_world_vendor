import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:easy_world_vendor/views/dashboard/orders_history_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OrderCardWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String orderNo;
  final String status;
  final Color statusColor;
  final String dateTime;
  final String price;
  final bool isDark;

  const OrderCardWidget({
    required this.imageUrl,
    required this.name,
    required this.orderNo,
    required this.status,
    required this.statusColor,
    required this.dateTime,
    required this.price,
    required this.isDark,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: InkWell(
        onTap: () {
          Get.to(() => OrderHistoryDetailScreen());
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        minRadius: 23,
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: CustomTextStyles.f14W600(
                              color:
                                  isDark
                                      ? AppColors.extraWhite
                                      : AppColors.blackColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Order No: $orderNo",
                            style: CustomTextStyles.f11W400(
                              color:
                                  isDark
                                      ? AppColors.extraWhite.withOpacity(0.7)
                                      : AppColors.secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      status,
                      style: CustomTextStyles.f11W600(color: statusColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                dateTime,
                style: CustomTextStyles.f12W400(
                  color:
                      isDark
                          ? AppColors.extraWhite.withOpacity(0.7)
                          : AppColors.secondaryTextColor,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: CustomTextStyles.f18W700(
                      color:
                          isDark
                              ? AppColors.primaryColor
                              : AppColors.secondaryColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(ImagePath.delete),
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
