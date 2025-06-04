import 'package:easy_world_vendor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomBar extends StatelessWidget {
  final String svgPath;
  final bool isActive;
  final VoidCallback onTap;

  const CustomBottomBar({
    super.key,
    required this.svgPath,
    required this.isActive,
    required this.onTap,
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
              height: 26,
              width: 26,
              color:
                  isActive
                      ? AppColors.primaryColor
                      : AppColors.secondaryTextColor,
            ),
            const SizedBox(height: 4),
            if (isActive)
              Container(
                height: 4,
                width: 24,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
