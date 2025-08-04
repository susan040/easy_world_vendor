import 'package:easy_world_vendor/controller/dash_screen_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:easy_world_vendor/widgets/custom/custom_bottom_nav_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashScreen extends StatelessWidget {
  final c = Get.put(DashScreenController());

  DashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      body: Obx(() => c.pages[c.currentIndex.value]),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          margin: EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 10),
          decoration: BoxDecoration(
            color: isDark ? AppColors.blackColor : AppColors.extraWhite,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: isDark ? AppColors.darkModeColor : AppColors.lGrey,
                blurRadius: 2,
                spreadRadius: 1.5,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => CustomBottomBar(
                  svgPath: ImagePath.home,
                  title: "Home",
                  isActive: c.currentIndex.value == 0,
                  onTap: () => c.currentIndex.value = 0,
                ),
              ),
              Obx(
                () => CustomBottomBar(
                  svgPath: ImagePath.orders,
                  title: "Orders",
                  isActive: c.currentIndex.value == 1,
                  onTap: () => c.currentIndex.value = 1,
                ),
              ),
              Obx(
                () => CustomBottomBar(
                  svgPath: ImagePath.product,
                  title: "Products",
                  isActive: c.currentIndex.value == 2,
                  onTap: () => c.currentIndex.value = 2,
                ),
              ),
              Obx(
                () => CustomBottomBar(
                  svgPath: ImagePath.profile,
                  title: "Profile",
                  isActive: c.currentIndex.value == 3,
                  onTap: () => c.currentIndex.value = 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
