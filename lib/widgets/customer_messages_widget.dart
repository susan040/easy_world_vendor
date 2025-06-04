import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';

class CustomMessagesWidget extends StatelessWidget {
  const CustomMessagesWidget({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      margin: EdgeInsets.only(bottom: 10),
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
            blurRadius: 1,
            spreadRadius: 1.5,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 45,
            decoration: BoxDecoration(
              color:
                  isDark
                      ? AppColors.blackColor.withOpacity(0.3)
                      : AppColors.extraWhite,
              borderRadius: BorderRadius.circular(13),
              image: DecorationImage(
                image: NetworkImage(
                  "https://blog.photofeeler.com/wp-content/uploads/2017/02/flattering-pose-profile-pics.jpeg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bill Jason",
                      style: CustomTextStyles.f12W600(
                        color:
                            isDark
                                ? AppColors.extraWhite
                                : AppColors.blackColor,
                      ),
                    ),
                    Text(
                      "5 min ago",
                      style: CustomTextStyles.f11W400(
                        color:
                            isDark
                                ? AppColors.extraWhite.withOpacity(0.7)
                                : AppColors.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "Hi! I want to know about this product. Hi! I want to know about this product.",
                  style: CustomTextStyles.f11W400(
                    color:
                        isDark
                            ? AppColors.extraWhite.withOpacity(0.7)
                            : AppColors.secondaryTextColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
