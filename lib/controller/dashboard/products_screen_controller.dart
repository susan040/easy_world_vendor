import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_world_vendor/controller/dashboard/network_controller.dart';
import 'package:easy_world_vendor/models/orders.dart';
import 'package:easy_world_vendor/models/products.dart';
import 'package:easy_world_vendor/models/review_replies.dart';
import 'package:easy_world_vendor/models/reviews.dart';
import 'package:easy_world_vendor/repo/delete_product_review_repo.dart';
import 'package:easy_world_vendor/repo/delete_review_reply_repo.dart';
import 'package:easy_world_vendor/repo/get_product_by_id_repo.dart';
import 'package:easy_world_vendor/repo/get_products_repo.dart';
import 'package:easy_world_vendor/repo/get_review_replies_repo.dart';
import 'package:easy_world_vendor/repo/get_reviews_repo.dart';
import 'package:easy_world_vendor/repo/reply_review_repo.dart';
import 'package:easy_world_vendor/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreenController extends GetxController {
  RxList<Data> allProductsFullList = <Data>[].obs;
  RxList<Data> allProductLists = <Data>[].obs;
  RxList<Reviews> allReviewsLists = <Reviews>[].obs;
  final networkController = Get.find<NetworkController>();
  RxList<ReviewReplies> allReviewsRepliedLists = <ReviewReplies>[].obs;
  final commentReplyController = TextEditingController();
  var isLoading = true.obs;
  RxString searchText = ''.obs;
  var product = Rxn<Data>();
  @override
  void onInit() {
    super.onInit();
    getAllProducts();
    getAllReviewsReplied();
    ever(networkController.connectivityStatus, (status) {
      if (status != null && status != ConnectivityResult.none) {
        if (allProductsFullList.isEmpty) {
          getAllProducts();
        }
      }
    });
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

  void fetchProductById(String id) {
    isLoading.value = true;
    GetProductByIdRepo.getProductByIdRepo(
      productId: id,
      onSuccess: (data) {
        product.value = data;
        isLoading.value = false;
      },
      onError: (msg) {
        isLoading.value = false;
        Get.snackbar("Error", msg);
      },
    );
  }

  getAllReviewsReplied() async {
    isLoading.value = true;
    await GetReviewRepliesRepo.getReviewRepliesRepo(
      onSuccess: (replies) {
        allReviewsRepliedLists.assignAll(replies);
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

  List<ReviewReplies> getRepliesForReview(String reviewId) {
    return allReviewsRepliedLists
        .where((e) => e.review?.id.toString() == reviewId)
        .toList();
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
    final replyText = commentReplyController.text.trim();
    commentReplyController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    isLoading.value = true;
    await ReplyReviewRepo.replyReviewRepo(
      reviewId: reviewId,
      reply: replyText,
      onSuccess: (message) async {
        isLoading.value = false;
        await getAllReviewsReplied();
        CustomSnackBar.success(title: "Reply", message: message);
      },
      onError: ((message) {
        isLoading.value = false;
        CustomSnackBar.error(title: "Reply", message: message);
      }),
    );
  }

  deleteProductReview(int reviewId) async {
    isLoading.value = true;
    await DeleteProductReviewRepo.deleteProductReviewRepo(
      reviewId: reviewId,
      onSuccess: (message) {
        isLoading.value = false;
        allReviewsLists.removeWhere((review) => review.id == reviewId);
        getAllReviewsByProductId(product.value?.id.toString() ?? "").then((
          reviews,
        ) {
          allReviewsLists.assignAll(reviews);
        });
        CustomSnackBar.success(title: "Review", message: message);
      },
      onError: ((message) {
        isLoading.value = false;
        CustomSnackBar.error(title: "Review", message: message);
      }),
    );
  }

  deleteReviewReply(int replyId) async {
    isLoading.value = true;
    await DeleteReviewReplyRepo.deleteReviewReplyRepo(
      replyId: replyId,
      onSuccess: (message) {
        isLoading.value = false;
        allReviewsLists.removeWhere((reply) => reply.id == replyId);
        getAllReviewsReplied();
        CustomSnackBar.success(title: "Review", message: message);
      },
      onError: ((message) {
        isLoading.value = false;
        CustomSnackBar.error(title: "Review", message: message);
      }),
    );
  }

  RxInt totalSold = 0.obs;

  // void calculateSold(List<Orders> orders, int productId) {
  //   int total = 0;
  //   for (var order in orders) {
  //     if (order.status?.toLowerCase() == 'delivered') {
  //       for (var item in order.items ?? []) {
  //         if (item.productId == productId) {
  //           total += int.parse(item.quantity ?? 0);
  //         }
  //       }
  //     }
  //   }
  //   totalSold.value = total;
  // }

  int calculateTotalSoldForProduct(List<Orders> orders, int productId) {
    int totalSold = 0;

    for (var order in orders) {
      if (order.status?.toLowerCase() == 'delivered') {
        for (var item in order.items ?? []) {
          // Check product_id directly
          final id = item.toJson()['product_id'] ?? 0;
          final quantity = item.toJson()['quantity'] ?? 0;

          if (id == productId) totalSold += int.parse(quantity.toString());
        }
      }
    }
    return totalSold;
  }
}
