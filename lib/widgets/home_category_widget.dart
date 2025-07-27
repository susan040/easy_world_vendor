import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String count;
  final String imagePath;
  final double imageHeight;
  final double imageWidth;
  final bool isDark;

  const CategoryCard({
    super.key,
    required this.title,
    required this.count,
    required this.imagePath,
    required this.isDark,
    required this.imageHeight,
    required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73,
      width: 170,
      padding: const EdgeInsets.only(left: 8, bottom: 12, top: 12, right: 8),
      decoration: BoxDecoration(
        color: AppColors.lightPrimaryColor,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: CustomTextStyles.f12W500(
                  color: AppColors.secondaryTextColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                count,
                style: CustomTextStyles.f12W600(color: AppColors.blackColor),
              ),
            ],
          ),
          Image.asset(imagePath, height: imageHeight, width: imageWidth),
        ],
      ),
    );
  }
}
