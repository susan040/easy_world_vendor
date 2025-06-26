import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:get/get.dart';

class PdfViewScreen extends StatelessWidget {
  final String pdfUrl;

  const PdfViewScreen({super.key, required this.pdfUrl});

  Future<String> _downloadAndSavePdf(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/temp.pdf');
    await file.writeAsBytes(bytes);
    return file.path;
  }

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
      body: FutureBuilder<String>(
        future: _downloadAndSavePdf(pdfUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load PDF'));
          }

          final path = snapshot.data!;
          return Container(
            color: bgColor,

            child: PDFView(
              filePath: path,
              autoSpacing: true,
              swipeHorizontal: false,
              pageSnap: true,
              fitPolicy: FitPolicy.BOTH,
              fitEachPage: true,
              backgroundColor:
                  isDark ? AppColors.darkModeColor : AppColors.extraWhite,
            ),
          );
        },
      ),
    );
  }
}
