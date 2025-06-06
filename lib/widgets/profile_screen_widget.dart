import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreenWidget extends StatelessWidget {
  const ProfileScreenWidget({super.key, required this.isDark});

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
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  placeholder:
                      (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                  imageUrl:
                      "https://i.pinimg.com/736x/ee/4f/e4/ee4fe4570751606a4d4e6339193814b8.jpg",
                  errorWidget:
                      (context, url, error) => Image.asset(
                        ImagePath.blankProfile,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 3,
                child: InkWell(
                  onTap: () {
                    // Get.to(() => EditProfileScreen());
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
              Text(
                "Hand Made General Store",
                style: CustomTextStyles.f14W700(
                  color: isDark ? AppColors.extraWhite : AppColors.blackColor,
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
                  Text(
                    "+61 412 345 678",
                    style: CustomTextStyles.f11W400(
                      color:
                          isDark ? AppColors.extraWhite : AppColors.blackColor,
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
                  Text(
                    "handmadegeneral@gmail.com",
                    style: CustomTextStyles.f11W400(
                      color:
                          isDark ? AppColors.extraWhite : AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.home_outlined,
                    size: 18.5,
                    color: AppColors.fieldVist,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Kathmandu, Nepal",
                    style: CustomTextStyles.f11W400(
                      color:
                          isDark ? AppColors.extraWhite : AppColors.blackColor,
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
