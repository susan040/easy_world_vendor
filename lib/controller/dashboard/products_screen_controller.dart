import 'package:get/get.dart';

class ProductsScreenController extends GetxController {
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
