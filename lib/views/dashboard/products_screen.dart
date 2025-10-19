import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_world_vendor/controller/dashboard/products_screen_controller.dart';
import 'package:easy_world_vendor/models/products.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/widgets/custom/custom_textfield.dart';
import 'package:easy_world_vendor/widgets/products_widget.dart';
import 'package:shimmer/shimmer.dart';

class ProductsScreen extends StatelessWidget {
  final c = Get.put(ProductsScreenController());
  ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        title: Text(
          "Products",
          style: CustomTextStyles.f16W600(
            color: isDark ? AppColors.extraWhite : AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor:
            isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                constraints: BoxConstraints(maxHeight: 47),
                child: CustomTextField(
                  fillColor:
                      isDark
                          ? AppColors.blackColor.withOpacity(0.15)
                          : AppColors.extraWhite,
                  hint: "Search",
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                  suffixIconPath: Icons.search,
                  onValueChange: (value) {
                    c.searchText.value = value;
                    c.applyFilters();
                    if (value.isEmpty) {
                      // Reset to full list when search is cleared
                      c.allProductLists.assignAll(c.allProductsFullList);
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 14),
              child: Obx(
                () =>
                    c.isLoading.value
                        ? SingleChildScrollView(
                          child: Shimmer.fromColors(
                            baseColor:
                                isDark ? Colors.grey[800]! : Colors.grey[300]!,
                            highlightColor:
                                isDark ? Colors.grey[700]! : Colors.grey[100]!,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(5, (index) {
                                return Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 12),
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                );
                              }),
                            ),
                          ),
                        )
                        : c.allProductLists.isEmpty
                        ? SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                              "No Products",
                              style: CustomTextStyles.f14W400(
                                color: AppColors.textGreyColor,
                              ),
                            ),
                          ),
                        )
                        : RefreshIndicator(
                          onRefresh: () async {
                            c.getAllProducts();
                          },
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: c.allProductLists.length,
                            itemBuilder: (context, index) {
                              final Data product = c.allProductLists[index];
                              return ProductsWidget(
                                isDark: isDark,
                                products: product,
                              );
                            },
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
