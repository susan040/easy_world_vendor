import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomBar extends StatelessWidget {
  final String svgPath;
  final bool isActive;
  final String title;
  final VoidCallback onTap;

  const CustomBottomBar({
    super.key,
    required this.svgPath,
    required this.isActive,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svgPath,
              height: 24,
              width: 24,
              color:
                  isActive
                      ? AppColors.primaryColor
                      : AppColors.secondaryTextColor,
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: CustomTextStyles.f12W600(
                color:
                    isActive
                        ? AppColors.primaryColor
                        : AppColors.secondaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
