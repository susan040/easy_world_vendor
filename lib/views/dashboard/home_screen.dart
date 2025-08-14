import 'package:easy_world_vendor/controller/dashboard/chat_screen_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/exchange_rate_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/home_screen_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/order_screen_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/products_screen_controller.dart';
import 'package:easy_world_vendor/models/all_chats.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:easy_world_vendor/views/chats/chat_products_screen.dart';
import 'package:easy_world_vendor/views/chats/customers_message_screen.dart';
import 'package:easy_world_vendor/widgets/customer_messages_widget.dart';
import 'package:easy_world_vendor/widgets/graph_widget.dart';
import 'package:easy_world_vendor/widgets/home_category_widget.dart';
import 'package:easy_world_vendor/widgets/home_screen_shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final c = Get.put(HomeScreenController());
  final orderController = Get.put(OrderScreenController());
  final productController = Get.put(ProductsScreenController());
  final exchangeRateController = Get.put(ExchangeRateController());
  final messageController = Get.put(ChatScreenController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        backgroundColor:
            isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        title: HomeScreenAppBar(isDark: isDark),
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 2,
        shadowColor: isDark ? Colors.transparent : AppColors.lGrey,
        actions: [HomeScreenNotificationWidget(isDark: isDark)],
      ),
      body: Obx(() {
        final isLoading =
            productController.isLoading.value ||
            orderController.isLoading.value ||
            c.isLoading.value ||
            messageController.isLoading.value;

        if (isLoading) {
          return HomePageShimmerWidget(isDark: isDark);
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Categories grid
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 12,
                  bottom: 8,
                ),
                child: Text(
                  "Categories",
                  style: CustomTextStyles.f14W600(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
              ),
              GridView.count(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                crossAxisCount: 2,
                mainAxisSpacing: 13,
                crossAxisSpacing: 13,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 170 / 73,
                children: [
                  // Products
                  Obx(
                    () => CategoryCard(
                      title: "Total Products",
                      count: "${productController.allProductLists.length}",
                      imagePath: ImagePath.totalProducts,
                      imageHeight: 51,
                      imageWidth: 51,
                      isDark: isDark,
                    ),
                  ),
                  // Orders
                  Obx(
                    () => CategoryCard(
                      title: "Total Orders",
                      count: "${orderController.allOrderLists.length}",
                      imagePath: ImagePath.totalOrders,
                      imageHeight: 45,
                      imageWidth: 45,
                      isDark: isDark,
                    ),
                  ),
                  // Total Earnings
                  Obx(() {
                    final rawNetEarnings = c.earningDetails.value?.netEarnings;
                    final earningsDouble =
                        double.tryParse(rawNetEarnings ?? "0.00") ?? 0.0;
                    final convertedEarnings = exchangeRateController
                        .convertPriceFromAUD(earningsDouble.toString())
                        .toStringAsFixed(2);
                    final code =
                        exchangeRateController.selectedCountryData['code'];
                    final symbol = code == 'NPR' ? 'Rs.' : '\$';

                    return CategoryCard(
                      title: "Total Earning",
                      count: "$symbol$convertedEarnings",
                      imagePath: ImagePath.totalEarnings,
                      imageHeight: 50,
                      imageWidth: 50,
                      isDark: isDark,
                    );
                  }),
                  // Gross Sales
                  Obx(() {
                    final rawGrossSales = c.earningDetails.value?.totalSales;
                    final salesDouble =
                        double.tryParse(rawGrossSales ?? "0.00") ?? 0.0;
                    final convertedSales = exchangeRateController
                        .convertPriceFromAUD(salesDouble.toString())
                        .toStringAsFixed(2);
                    final code =
                        exchangeRateController.selectedCountryData['code'];
                    final symbol = code == 'NPR' ? 'Rs.' : '\$';

                    return CategoryCard(
                      title: "Gross Sales",
                      count: "$symbol$convertedSales",
                      imagePath: ImagePath.grossSales,
                      imageHeight: 45,
                      imageWidth: 45,
                      isDark: isDark,
                    );
                  }),
                ],
              ),
              // Sales Chart
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: Text(
                  "Sales Chart",
                  style: CustomTextStyles.f14W600(
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: GraphWidget(isDark: isDark, c: c),
              ),
              // Recent Messages Header
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Messages",
                      style: CustomTextStyles.f14W600(
                        color:
                            isDark
                                ? AppColors.extraWhite
                                : AppColors.blackColor,
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.to(() => CustomersMessageScreen()),
                      child: Text(
                        "View All",
                        style: CustomTextStyles.f12W400(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Messages List
              Obx(() {
                final groupedChats = <int, List<AllChats>>{};
                for (var chat in messageController.allChatsLists) {
                  if (chat.customer?.id == null) continue;
                  final customId = chat.customer!.id!;
                  if (!groupedChats.containsKey(customId))
                    groupedChats[customId] = [];
                  groupedChats[customId]!.add(chat);
                }

                if (groupedChats.isEmpty)
                  return SizedBox(
                    height: 70,
                    child: Center(
                      child: Text(
                        "No messages",
                        style: CustomTextStyles.f12W400(
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ),
                  );

                final customerChatsLists = groupedChats.values.toList();
                final latestChats =
                    customerChatsLists.length > 4
                        ? customerChatsLists.sublist(
                          customerChatsLists.length - 4,
                        )
                        : customerChatsLists;

                return ListView.builder(
                  itemCount: latestChats.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final customChats = latestChats[index];
                    final chats = customChats.last;
                    return Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: InkWell(
                        onTap: () {
                          Get.to(
                            () =>
                                ChatProductsScreen(customerChats: customChats),
                          );
                        },
                        child: CustomMessagesWidget(
                          isDark: isDark,
                          chats: chats,
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}
