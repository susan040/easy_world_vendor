import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';

class ReviewBox extends StatelessWidget {
  final String name;
  final String review;
  final bool isDark;
  final int rating;
  final List<String> photos;

  const ReviewBox({
    Key? key,
    required this.name,
    required this.review,
    required this.isDark,
    this.rating = 5,
    this.photos = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                name,
                style: CustomTextStyles.f14W600(
                  color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    size: 16,
                    color: Colors.amber,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review,
            style: CustomTextStyles.f12W400(
              color:
                  isDark
                      ? AppColors.extraWhite.withOpacity(0.8)
                      : AppColors.secondaryTextColor,
            ),
          ),
          const SizedBox(height: 10),
          if (photos.isNotEmpty)
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      photos[index],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
