import 'package:easy_world_vendor/models/products.dart';
import 'package:easy_world_vendor/repo/get_products_repo.dart';
import 'package:get/get.dart';

class ProductsScreenController extends GetxController {
  RxList<Data> allProductsFullList = <Data>[].obs; // full original list
  RxList<Data> allProductLists = <Data>[].obs; // filtered list shown on UI
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

  final RxList<Map<String, dynamic>> reviews =
      <Map<String, dynamic>>[
        {
          'name': 'Emily',
          'review': 'Very cute! The quality is amazing and it arrived quickly.',
          'rating': 5,
          'photos': [
            "https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg",
            "https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg",
          ],
        },
        {
          'name': 'Liam',
          'review': 'Bought this as a gift for my sister and she loved it!',
          'rating': 4,
          'photos': [
            "https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg",
            "https://mindy.hu/pictures_en/3883_little-amigurumi-bear-keychain-free-crochet-pattern.jpg",
          ],
        },
        {
          'name': 'Sophia',
          'review': 'Nicely made and looks even better in real life!',
          'rating': 5,
          'photos': [],
        },
      ].obs;

  double get averageRating {
    final totalRating = reviews.fold<double>(
      0,
      (sum, item) => sum + (item['rating'] as int),
    );
    return totalRating / reviews.length;
  }

  int get totalReviews => reviews.length;
}
