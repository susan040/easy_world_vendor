import 'package:easy_world_vendor/models/products.dart';
import 'package:easy_world_vendor/models/reviews.dart';
import 'package:easy_world_vendor/repo/get_products_repo.dart';
import 'package:easy_world_vendor/repo/get_reviews_repo.dart';
import 'package:get/get.dart';

class ProductsScreenController extends GetxController {
  RxList<Data> allProductsFullList = <Data>[].obs;
  RxList<Data> allProductLists = <Data>[].obs;
  RxList<Reviews> allReviewsLists = <Reviews>[].obs;
  var isLoading = true.obs;
  RxString searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getAllProducts();
    getAllReviews();
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

  getAllReviews() async {
    isLoading.value = true;
    await GetReviewsRepo.getReviewsRepo(
      onSuccess: (reviews) {
        isLoading.value = false;
        allReviewsLists.assignAll(reviews);
      },
      onError: (msg) {
        isLoading.value = false;
        print("Error: $msg");
      },
    );
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

  double calculateAverageRating(List<Reviews> reviews) {
    if (reviews.isEmpty) return 0.0;

    double total = 0;
    int count = 0;

    for (var review in reviews) {
      if (review.rating != null && review.rating!.isNotEmpty) {
        double? rating = double.tryParse(review.rating!);
        if (rating != null) {
          total += rating;
          count++;
        }
      }
    }

    return count > 0 ? total / count : 0.0;
  }
}
