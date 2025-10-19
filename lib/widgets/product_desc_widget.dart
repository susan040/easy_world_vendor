import 'package:barcode/barcode.dart';
import 'package:easy_world_vendor/controller/dashboard/products_screen_controller.dart';
import 'package:easy_world_vendor/models/products.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProductDetailsWidget extends StatelessWidget {
  ProductDetailsWidget({
    super.key,
    required this.isDark,
    required this.products,
  });
  final bool isDark;
  final c = Get.put(ProductsScreenController());
  final Data products;

  @override
  Widget build(BuildContext context) {
    final cleanBarcode = products.barcode!.trim();
    final barcode =
        RegExp(r'^\d{13}$').hasMatch(cleanBarcode)
            ? Barcode.ean13()
            : Barcode.code128();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: CustomTextStyles.f14W600(
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          products.description ?? "",
          style: CustomTextStyles.f13W400(
            color:
                isDark
                    ? AppColors.extraWhite.withOpacity(0.6)
                    : AppColors.secondaryTextColor,
          ),
          textAlign: TextAlign.justify,
        ),

        const SizedBox(height: 16),
        Text(
          "Product Details",
          style: CustomTextStyles.f14W600(
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 8),

        if (products.category?.categoryImage != null)
          _buildDetailRow(
            title: "Category",
            value: products.category!.categoryName!,
            isDark: isDark,
          ),
        if (products.sku != null && products.sku!.isNotEmpty)
          _buildDetailRow(title: "SKU", value: products.sku!, isDark: isDark),
        if (products.size != null && products.size!.isNotEmpty)
          _buildDetailRow(
            title: "Size",
            value: products.size!.join(", "),
            isDark: isDark,
          ),
        if (products.color != null && products.color!.isNotEmpty)
          _buildDetailRow(
            title: "Color",
            value: products.color!.join(", "),
            isDark: isDark,
          ),
        if (products.weight != null && products.weight!.isNotEmpty)
          _buildDetailRow(
            title: "Weight",
            value: "${products.weight} ${products.weightUnit ?? ''}".trim(),
            isDark: isDark,
          ),
          

        if (products.barcode != null && products.barcode!.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            "Product Barcode",
            style: CustomTextStyles.f14W600(
              color: isDark ? AppColors.extraWhite : AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.only(
              right: 8,
              left: 8,
              top: 10,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: AppColors.extraWhite,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.string(
                  barcode.toSvg(
                    cleanBarcode,
                    width: Get.width / 3,
                    height: 35,
                    drawText: true,
                  ),
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDetailRow({
    required String title,
    required String value,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              "$title:",
              style: CustomTextStyles.f13W400(
                color:
                    isDark
                        ? AppColors.extraWhite.withOpacity(0.7)
                        : AppColors.secondaryTextColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: CustomTextStyles.f13W400(
                color:
                    isDark
                        ? AppColors.extraWhite.withOpacity(0.6)
                        : AppColors.secondaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
