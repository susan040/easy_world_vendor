import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:easy_world_vendor/views/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileScreenWidget extends StatelessWidget {
  final coreController = Get.put(CoreController());
  ProfileScreenWidget({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 14),
      width: double.infinity,
      decoration: BoxDecoration(
        color:
            isDark
                ? AppColors.blackColor.withOpacity(0.3)
                : AppColors.extraWhite,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.transparent : AppColors.lGrey,
            blurRadius: 1.5,
            spreadRadius: 2.5,
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 12),
          Stack(
            children: [
              Obx(
                () => ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                    imageUrl:
                        coreController.currentUser.value!.data!.profileImage ??
                        "",
                    errorWidget:
                        (context, url, error) => Image.asset(
                          ImagePath.blankProfile,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 3,
                child: InkWell(
                  onTap: () {
                    Get.to(() => EditProfileScreen());
                  },
                  child: CircleAvatar(
                    radius: 13,
                    backgroundColor: AppColors.primaryColor,
                    child: SvgPicture.asset(
                      ImagePath.editProfile,
                      color: AppColors.extraWhite,
                      height: 15,
                      width: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          Container(
            width: 2,
            height: 130,
            decoration: BoxDecoration(
              color: isDark ? AppColors.extraWhite : AppColors.lGrey,
            ),
          ),
          SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  coreController.currentUser.value!.data!.storeName ??
                      "no name",
                  style: CustomTextStyles.f14W700(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.phone_outlined,
                    size: 16,
                    color: AppColors.accepted,
                  ),
                  SizedBox(width: 4),
                  Obx(
                    () => Text(
                      coreController.currentUser.value!.data!.phone ??
                          "no phone number",
                      style: CustomTextStyles.f11W400(
                        color:
                            isDark
                                ? AppColors.extraWhite
                                : AppColors.blackColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 16,
                    color: AppColors.darkblue,
                  ),
                  SizedBox(width: 4),
                  Obx(
                    () => Text(
                      coreController.currentUser.value!.data!.email ??
                          "no email",
                      style: CustomTextStyles.f11W400(
                        color:
                            isDark
                                ? AppColors.extraWhite
                                : AppColors.blackColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.description,
                    size: 18.5,
                    color: AppColors.fieldVist,
                  ),
                  SizedBox(width: 4),
                  Obx(
                    () => SizedBox(
                      width: 160,
                      child: Text(
                        coreController
                                .currentUser
                                .value!
                                .data!
                                .storeDescription ??
                            "no description",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.f11W400(
                          color:
                              isDark
                                  ? AppColors.extraWhite
                                  : AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
