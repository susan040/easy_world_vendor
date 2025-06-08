import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Chat",
          style: CustomTextStyles.f16W600(
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 20),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  maxRadius: 20,
                  backgroundImage: NetworkImage(
                    "https://i.pinimg.com/736x/ee/4f/e4/ee4fe4570751606a4d4e6339193814b8.jpg",
                  ),
                ),
                ProductCard(isDark: isDark),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 12.0, top: 10),
              child: Text(
                '14:53',
                style: CustomTextStyles.f11W400(
                  color:
                      isDark ? AppColors.lGrey : AppColors.secondaryTextColor,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ChatBubble(text: 'Hello how may I help you?', isSender: true),
                CircleAvatar(
                  maxRadius: 20,
                  backgroundImage: NetworkImage(
                    "https://i.pinimg.com/736x/ee/4f/e4/ee4fe4570751606a4d4e6339193814b8.jpg",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: CustomTextStyles.f12W400(
                  color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                ),
                decoration: InputDecoration(
                  hintText: "Ask short and simple questions here",
                  hintStyle: CustomTextStyles.f12W400(
                    color:
                        isDark
                            ? AppColors.extraWhite
                            : AppColors.secondaryTextColor,
                  ),
                  fillColor:
                      isDark ? AppColors.textGreyColor : AppColors.extraWhite,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: AppColors.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: AppColors.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: AppColors.errorColor,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: AppColors.errorColor,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  ProductCard({super.key, required this.isDark});
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      decoration: BoxDecoration(
        color:
            isDark
                ? AppColors.blackColor.withOpacity(0.2)
                : AppColors.extraWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg',
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Crochet Bear',
                style: CustomTextStyles.f12W600(
                  color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '4.5',
                    style: CustomTextStyles.f11W400(
                      color:
                          isDark
                              ? AppColors.lGrey
                              : AppColors.secondaryTextColor,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightPrimaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      '1000 sold',
                      style: CustomTextStyles.f10W500(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '\$10.00',
                style: CustomTextStyles.f14W600(
                  color:
                      isDark
                          ? AppColors.primaryColor
                          : AppColors.secondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;

  const ChatBubble({super.key, required this.text, this.isSender = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSender ? AppColors.primaryColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: CustomTextStyles.f12W400(
            color: isSender ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
