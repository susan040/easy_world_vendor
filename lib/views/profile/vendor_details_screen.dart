import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/views/profile/pdf_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorDetailsScreen extends StatelessWidget {
  final coreController = Get.put(CoreController());
  VendorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkModeColor : AppColors.extraWhite;
    final textColor = isDark ? AppColors.extraWhite : AppColors.blackColor;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Vendor Details',
          style: CustomTextStyles.f16W700(color: textColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 5,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                  child: Icon(
                    Icons.storefront,
                    size: 55,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  coreController.currentUser.value!.data!.storeName ?? "",
                  style: CustomTextStyles.f18W700(color: textColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 6),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  child: Text(
                    coreController.currentUser.value!.data!.storeDescription ??
                        "",
                    style: CustomTextStyles.f11W400(
                      color: textColor.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              InfoCard(
                icon: Icons.email,
                label: "Email",
                title: coreController.currentUser.value!.data!.email ?? "",
                textColor: textColor,
                isDark: isDark,
              ),
              const SizedBox(height: 8),
              InfoCard(
                icon: Icons.phone,
                label: "Phone",
                title: coreController.currentUser.value!.data!.phone ?? "",
                textColor: textColor,
                isDark: isDark,
              ),
              const SizedBox(height: 8),
              InfoCard(
                icon: Icons.flag,
                label: "Country Code",
                title:
                    coreController.currentUser.value!.data!.countryCode ?? "",
                textColor: textColor,
                isDark: isDark,
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  final pdfUrl =
                      coreController
                          .currentUser
                          .value!
                          .data!
                          .documentRegistration ??
                      "";
                  if (pdfUrl.isNotEmpty) {
                    Get.to(() => PdfViewScreen(pdfUrl: pdfUrl));
                  } else {
                    Get.snackbar("Error", "No document found");
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? AppColors.blackColor.withOpacity(0.3)
                            : AppColors.extraWhite,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.transparent : AppColors.lGrey,
                        blurRadius: 1,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.picture_as_pdf, color: Colors.redAccent),
                      const SizedBox(width: 12),
                      Text(
                        "Open Document.pdf",
                        style: CustomTextStyles.f14W500(color: textColor),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.open_in_new, color: textColor),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String title;
  final Color textColor;
  final bool isDark;
  const InfoCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.title,
    required this.textColor,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color:
            isDark
                ? AppColors.blackColor.withOpacity(0.3)
                : AppColors.extraWhite,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.transparent : AppColors.lGrey,
            blurRadius: 1,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 28),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: CustomTextStyles.f14W600(
                  color: textColor.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 6),
              Text(title, style: CustomTextStyles.f14W500(color: textColor)),
            ],
          ),
        ],
      ),
    );
  }
}
