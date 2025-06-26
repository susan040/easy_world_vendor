import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/country_controller.dart';
import 'package:easy_world_vendor/controller/theme_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:easy_world_vendor/views/profile/bank_details_screen.dart';
import 'package:easy_world_vendor/views/profile/edit_profile_screen.dart';
import 'package:easy_world_vendor/views/profile/request_payout_screen.dart';
import 'package:easy_world_vendor/views/profile/vendor_details_screen.dart';
import 'package:easy_world_vendor/widgets/profile_options_widget.dart';
import 'package:easy_world_vendor/widgets/profile_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final coreController = Get.put(CoreController());
  final countryController = Get.put(CountryController());
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: CustomTextStyles.f16W600(
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor:
            isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileScreenWidget(isDark: isDark),
            ProfileOptionTile(
              iconPath: ImagePath.verified,
              title: "Verified",
              onTap: () {
                Get.to(() => VendorDetailsScreen());
              },
              isDark: isDark,
              isVerified: true,
            ),
            ProfileOptionTile(
              iconPath: ImagePath.editProfile,
              title: "Edit Profile",
              onTap: () {
                Get.to(() => EditProfileScreen());
              },
              isDark: isDark,
            ),
            ProfileOptionTile(
              iconPath: ImagePath.payment,
              title: "Add Bank Details",
              onTap: () {
                Get.to(() => AddBankDetailsScreen());
              },
              isDark: isDark,
            ),
            ProfileOptionTile(
              iconPath: ImagePath.history,
              title: "Request Payout",
              onTap: () {
                Get.to(() => RequestPayoutScreen());
              },
              isDark: isDark,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 3.5,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 59,
                decoration: BoxDecoration(
                  color:
                      isDark
                          ? AppColors.blackColor.withOpacity(0.3)
                          : AppColors.lGrey,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          ImagePath.darkMode,
                          color:
                              isDark
                                  ? AppColors.extraWhite
                                  : AppColors.secondaryColor,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Dark Mode",
                          style: CustomTextStyles.f12W400(
                            color:
                                (isDark
                                    ? AppColors.extraWhite
                                    : AppColors.blackColor),
                          ),
                        ),
                      ],
                    ),

                    FlutterSwitch(
                      width: 65,
                      height: 26,
                      value: isDark,
                      borderRadius: 30,
                      activeColor: AppColors.secondaryColor,
                      inactiveColor: AppColors.extraWhite,
                      switchBorder: Border.all(
                        width: 1,
                        color:
                            isDark
                                ? AppColors.blackColor
                                : AppColors.secondaryColor,
                      ),
                      activeText: "ON",
                      inactiveText: "OFF",
                      activeTextColor: AppColors.extraWhite,
                      inactiveTextColor: AppColors.secondaryColor,
                      activeTextFontWeight: FontWeight.normal,
                      inactiveTextFontWeight: FontWeight.normal,
                      valueFontSize: 13,
                      toggleColor:
                          isDark
                              ? AppColors.extraWhite
                              : AppColors.secondaryColor,
                      showOnOff: true,
                      onToggle: themeController.toggleTheme,
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              final country = countryController.selectedCountryData;

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 3.5,
                ),
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(CountryBottomSheet());
                  },
                  child: Container(
                    height: 59,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color:
                          isDark
                              ? AppColors.blackColor.withOpacity(0.3)
                              : AppColors.lGrey,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              country['flag']!,
                              width: 24,
                              height: 24,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "${country['name']} (${country['code']})",
                              style: CustomTextStyles.f12W400(
                                color:
                                    isDark
                                        ? AppColors.extraWhite
                                        : AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          ImagePath.arrowRight,
                          color:
                              isDark
                                  ? AppColors.extraWhite
                                  : AppColors.secondaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            ProfileOptionTile(
              iconPath: ImagePath.logOut,
              title: "Log Out",
              onTap: () {
                coreController.logOut();
              },
              isLogout: true,
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }
}
