import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';

class NoNetworkWidget extends StatelessWidget {
  const NoNetworkWidget({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off,
            size: 60,
            color: isDark ? AppColors.lGrey : AppColors.secondaryTextColor,
          ),
          const SizedBox(height: 16),
          Text(
            "No Internet Connection",
            style: CustomTextStyles.f14W700(
              color: isDark ? AppColors.extraWhite : AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Please check your connection\nand try again.",
            style: CustomTextStyles.f12W400(
              color: isDark ? AppColors.lGrey : AppColors.secondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
