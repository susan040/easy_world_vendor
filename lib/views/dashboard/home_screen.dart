import 'package:easy_world_vendor/controller/core_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/chat_screen_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/exchange_rate_controller.dart'
    show ExchangeRateController;
import 'package:easy_world_vendor/controller/dashboard/home_screen_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/notification_screen_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/order_screen_controller.dart';
import 'package:easy_world_vendor/controller/dashboard/products_screen_controller.dart';
import 'package:easy_world_vendor/models/all_chats.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:easy_world_vendor/views/dashboard/customers_message_screen.dart';
import 'package:easy_world_vendor/views/dashboard/notification_screen.dart';
import 'package:easy_world_vendor/widgets/customer_messages_widget.dart';
import 'package:easy_world_vendor/widgets/graph_widget.dart';
import 'package:easy_world_vendor/widgets/home_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  final c = Get.put(HomeScreenController());
  final orderController = Get.put(OrderScreenController());
  final productController = Get.put(ProductsScreenController());
  final coreController = Get.put(CoreController());
  final exchangeRateController = Get.put(ExchangeRateController());
  final messageController = Get.put(ChatScreenController());
  final notificationController = Get.put(NotificationController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkModeColor : AppColors.extraWhite,
      appBar: AppBar(
        backgroundColor:
            isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Hi, ${coreController.currentUser.value!.data!.storeName}",
              style: CustomTextStyles.f16W600(
                color: isDark ? AppColors.extraWhite : AppColors.blackColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('d MMMM, yyyy').format(DateTime.now()),
              style: CustomTextStyles.f12W400(
                color:
                    isDark
                        ? AppColors.extraWhite.withOpacity(0.7)
                        : AppColors.secondaryTextColor,
              ),
            ),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 2,
        shadowColor: isDark ? Colors.transparent : AppColors.lGrey,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Container(
              height: 33,
              width: 33,
              decoration: BoxDecoration(
                color:
                    isDark
                        ? AppColors.darkGrey.withOpacity(0.6)
                        : AppColors.extraWhite,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: isDark ? AppColors.darkModeColor : AppColors.lGrey,
                    spreadRadius: 1.5,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  Get.to(() => NotificationScreen());
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        ImagePath.notification,
                        color:
                            isDark
                                ? AppColors.extraWhite
                                : AppColors.darkModeColor,
                      ),
                    ),
                    Obx(() {
                      final unread = notificationController.unreadCount;
                      return unread > 0
                          ? Positioned(
                            top: 3,
                            right: 3,
                            child: Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                color: AppColors.rejected,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  unread.toString(),
                                  style: CustomTextStyles.f10W400(
                                    color: AppColors.extraWhite,
                                  ),
                                ),
                              ),
                            ),
                          )
                          : SizedBox();
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Categories",
                style: CustomTextStyles.f14W600(
                  color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                ),
              ),
              SizedBox(height: 8),
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 13,
                crossAxisSpacing: 13,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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

                  // Total Earnings from API
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
              SizedBox(height: 16),
              Text(
                "Sales Chart",
                style: CustomTextStyles.f14W600(
                  color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                ),
              ),
              SizedBox(height: 8),
              // HomeBarChartWidget(isDark: isDark, c: c),
              GraphWidget(isDark: isDark, c: c),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Messages",
                    style: CustomTextStyles.f14W600(
                      color:
                          isDark ? AppColors.extraWhite : AppColors.blackColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => CustomersMessageScreen());
                    },
                    child: Text(
                      "View All",
                      style: CustomTextStyles.f12W400(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              Obx(
                () =>
                    (messageController.isLoading.value)
                        ? Center(child: CircularProgressIndicator())
                        : messageController.allChatsLists.isEmpty
                        ? Center(child: Text("No messages"))
                        : ListView.builder(
                          itemCount: messageController.allChatsLists.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final AllChats chats =
                                messageController.allChatsLists[index];
                            return CustomMessagesWidget(
                              isDark: isDark,
                              chats: chats,
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
