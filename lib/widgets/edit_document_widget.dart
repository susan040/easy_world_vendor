import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_world_vendor/controller/dashboard/profile_screen_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDocumentWidget extends StatelessWidget {
  const EditDocumentWidget({super.key, required this.c, required this.isDark});

  final ProfileScreenController c;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isPdf = c.selectedFilePath.value.endsWith(".pdf");

      if (c.selectedFilePath.value.isNotEmpty) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    isPdf ? Icons.picture_as_pdf : Icons.insert_photo,
                    color: isPdf ? Colors.red : AppColors.primaryColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      c.pdfFileName.value,
                      style: CustomTextStyles.f12W500(
                        color: isDark ? AppColors.grey : AppColors.blackColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      c.pdfFileName.value = '';
                      c.selectedFilePath.value = '';
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                      isDark
                          ? AppColors.blackColor.withOpacity(0.2)
                          : AppColors.extraWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    isPdf
                        ? const Center(
                          child: Icon(
                            Icons.picture_as_pdf,
                            color: Colors.red,
                            size: 60,
                          ),
                        )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(c.selectedFilePath.value),
                            fit: BoxFit.cover,
                          ),
                        ),
              ),
            ],
          ),
        );
      } else {
        return GestureDetector(
          onTap: () => c.pickFile(),
          child: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              color: isDark ? AppColors.extraWhite : AppColors.textGreyColor,
              strokeWidth: 1,
              dashPattern: [8, 4],
              radius: const Radius.circular(10),
              padding: EdgeInsets.all(16),
            ),
            child: Container(
              height: 140,
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_file,
                    size: 28,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Tap to upload file",
                    style: CustomTextStyles.f12W400(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
