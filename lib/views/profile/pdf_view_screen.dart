import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:get/get.dart';

class PdfViewScreen extends StatelessWidget {
  final String pdfUrl;

  const PdfViewScreen({super.key, required this.pdfUrl});

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
          'Document PDF',
          style: CustomTextStyles.f16W700(color: textColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: SfPdfViewer.network(pdfUrl),
      ),
    );
  }
}
