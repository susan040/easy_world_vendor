import 'package:easy_world_vendor/controller/dashboard/products_screen_controller.dart';
import 'package:easy_world_vendor/models/reviews.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/views/dashboard/full_image_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewBox extends StatelessWidget {
  final bool isDark;
  final Reviews reviews;
  final controller = Get.put(ProductsScreenController());
  ReviewBox({Key? key, required this.isDark, required this.reviews})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = reviews.reviewImages ?? [];
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.blackColor.withOpacity(0.3) : AppColors.lGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                reviews.customer!.name ?? "",
                style: CustomTextStyles.f14W600(
                  color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < int.parse(reviews.rating ?? "")
                        ? Icons.star
                        : Icons.star_border,
                    size: 16,
                    color: Colors.amber,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            reviews.comment ?? "",
            style: CustomTextStyles.f12W400(
              color:
                  isDark
                      ? AppColors.extraWhite.withOpacity(0.8)
                      : AppColors.secondaryTextColor,
            ),
          ),
          const SizedBox(height: 10),
          (imageUrls.isNotEmpty)
              ? SizedBox(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageUrls.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 6),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => FullImageViewScreen(imageUrl: imageUrls[index]),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrls[index],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              )
              : const SizedBox.shrink(),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Write a reply...",
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    hintStyle: TextStyle(
                      color:
                          isDark
                              ? AppColors.extraWhite.withOpacity(0.6)
                              : AppColors.secondaryTextColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        width: 0.5,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  style: CustomTextStyles.f12W400(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                icon: Icon(
                  Icons.send,
                  color:
                      isDark
                          ? AppColors.primaryColor
                          : AppColors.secondaryColor,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
