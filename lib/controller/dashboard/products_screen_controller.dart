import 'dart:async';

import 'package:easy_world_vendor/models/products.dart';
import 'package:easy_world_vendor/models/reviews.dart';
import 'package:easy_world_vendor/repo/get_products_repo.dart';
import 'package:easy_world_vendor/repo/get_reviews_repo.dart';
import 'package:easy_world_vendor/repo/reply_review_repo.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreenController extends GetxController {
  RxList<Data> allProductsFullList = <Data>[].obs;
  RxList<Data> allProductLists = <Data>[].obs;
  RxList<Reviews> allReviewsLists = <Reviews>[].obs;
  final commentReplyController = TextEditingController();
  var isLoading = true.obs;
  RxString searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getAllProducts();
  }

  getAllProducts() async {
    isLoading.value = true;
    await GetProductsRepo.getProductsRepo(
      onSuccess: (Products productModel) {
        allProductsFullList.assignAll(productModel.data ?? []);
        allProductLists.assignAll(allProductsFullList);
        isLoading.value = false;
      },
      onError: (msg) {
        isLoading.value = false;
        print("Error: $msg");
      },
    );
  }

  Future<List<Reviews>> getAllReviewsByProductId(String productId) async {
    try {
      final completer = Completer<List<Reviews>>();

      await GetReviewsRepo.getReviewsRepo(
        productId: productId,
        onSuccess: (reviews) {
          completer.complete(reviews);
        },
        onError: (msg) {
          completer.completeError(msg);
        },
      );

      return completer.future;
    } catch (e) {
      return Future.error("Something went wrong");
    }
  }

  double calculateAverageRating(List<Reviews> reviewsList) {
    if (reviewsList.isEmpty) return 0.0;

    double total = reviewsList.fold(
      0.0,
      (sum, item) => sum + double.parse((item.rating.toString())),
    );
    return total / reviewsList.length;
  }

  void applyFilters() {
    List<Data> filtered = allProductsFullList.toList();

    if (searchText.value.isNotEmpty) {
      final query = searchText.value.toLowerCase();
      filtered =
          filtered.where((product) {
            final nameMatch =
                product.name?.toLowerCase().contains(query) ?? false;
            final categoryMatch =
                (product.category?.categoryName?.toLowerCase() ?? '').contains(
                  query,
                );
            final tagsMatch =
                product.tags?.any((tag) => tag.toLowerCase().contains(query)) ??
                false;
            return nameMatch || categoryMatch || tagsMatch;
          }).toList();
    }

    allProductLists.assignAll(filtered);
  }

  void replyReview(String reviewId) async {
    if (commentReplyController.text.trim().isEmpty) return;

    // Save & clear immediately to improve responsiveness
    final replyText = commentReplyController.text.trim();
    commentReplyController.clear();
    FocusManager.instance.primaryFocus?.unfocus(); // Dismiss keyboard

    isLoading.value = true;

    await ReplyReviewRepo.replyReviewRepo(
      reviewId: reviewId,
      reply: replyText,
      onSuccess: (message) {
        isLoading.value = false;
        CustomSnackBar.success(title: "Reply", message: message);
      },
      onError: ((message) {
        isLoading.value = false;
        CustomSnackBar.error(title: "Reply", message: message);
      }),
    );
  }
}
