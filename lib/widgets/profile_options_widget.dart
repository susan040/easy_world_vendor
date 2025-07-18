import 'package:easy_world_vendor/controller/dashboard/exchange_rate_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileOptionTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;
  final bool isLogout;
  final bool isEdit;
  final bool isVerified;
  final bool isDark;

  const ProfileOptionTile({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.isLogout = false,
    this.isEdit = false,
    required this.isDark,
    this.isVerified = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3.5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 59,
          decoration: BoxDecoration(
            color:
                isDark
                    ? AppColors.blackColor.withOpacity(0.3)
                    : AppColors.lGrey,
            borderRadius:
                isLogout
                    ? const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )
                    : isEdit
                    ? BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )
                    : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    iconPath,
                    color:
                        isVerified
                            ? AppColors.accepted
                            : isLogout
                            ? AppColors.errorColor
                            : isDark
                            ? AppColors.extraWhite
                            : AppColors.secondaryColor,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: CustomTextStyles.f12W400(
                      color:
                          isLogout
                              ? AppColors.errorColor
                              : (isDark
                                  ? AppColors.extraWhite
                                  : AppColors.blackColor),
                    ),
                  ),
                ],
              ),
              if (!isLogout)
                SvgPicture.asset(
                  ImagePath.arrowRight,
                  color:
                      isDark ? AppColors.extraWhite : AppColors.secondaryColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryBottomSheet extends StatelessWidget {
  final countryController = Get.put(ExchangeRateController());

  CountryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose Country',
            style: CustomTextStyles.f14W600(
              color: isDark ? AppColors.extraWhite : AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 12),
          ...countryController.allCountries.map((country) {
            return ListTile(
              leading: Image.asset(
                country['flag']!,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
              title: Text(
                "${country['name']} (${country['code']})",
                style: CustomTextStyles.f12W400(
                  color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                ),
              ),
              onTap: () {
                countryController.updateSelectedCountry(country);
                countryController.editCurrencyPreference();
                Get.back();
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
