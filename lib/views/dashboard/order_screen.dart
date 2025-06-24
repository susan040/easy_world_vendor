import 'package:easy_world_vendor/controller/dashboard/order_screen_controller.dart';
import 'package:easy_world_vendor/models/orders.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/widgets/order_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  final c = Get.put(OrderScreenController());
  OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor:
            isDark ? AppColors.darkModeColor : AppColors.extraWhite,
        appBar: AppBar(
          title: Text(
            "Orders",
            style: CustomTextStyles.f16W600(
              color: isDark ? AppColors.extraWhite : AppColors.blackColor,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor:
              isDark ? AppColors.darkModeColor : AppColors.extraWhite,
          elevation: 0,
          bottom: TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 12),
            labelColor: AppColors.primaryColor,
            indicatorColor: AppColors.primaryColor,
            labelStyle: CustomTextStyles.f12W600(),
            tabs: [
              Tab(
                child: Center(child: Text("All", textAlign: TextAlign.center)),
              ),
              Tab(
                child: Center(
                  child: Text("To\nPay", textAlign: TextAlign.center),
                ),
              ),
              Tab(
                child: Center(
                  child: Text("To\nShip", textAlign: TextAlign.center),
                ),
              ),
              Tab(
                child: Center(
                  child: Text("To\nReceive", textAlign: TextAlign.center),
                ),
              ),
              Tab(
                child: Center(
                  child: Text("Cancel\nlations", textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              // OrderCardWidget(
              //   imageUrl:
              //       "https://blog.photofeeler.com/wp-content/uploads/2017/02/flattering-pose-profile-pics.jpeg",
              //   name: "Sana Afzal",
              //   orderNo: "21893242380430",
              //   status: "Seller to pack",
              //   statusColor: AppColors.primaryColor,
              //   dateTime:
              //       "Order placed on Wednesday, 21 May 2025 at 2:30 PM",
              //   price: "\$40.00",
              //   isDark: isDark,
              // ),
              // OrderCardWidget(
              //   imageUrl:
              //       "https://blog.photofeeler.com/wp-content/uploads/2017/02/flattering-pose-profile-pics.jpeg",
              //   name: "Sana Afzal",
              //   orderNo: "21893242380430",
              //   status: "Delivered",
              //   statusColor: AppColors.accepted,
              //   dateTime:
              //       "Order placed on Wednesday, 21 May 2025 at 2:30 PM",
              //   price: "\$40.00",
              //   isDark: isDark,
              // ),
              // OrderCardWidget(
              //   imageUrl:
              //       "https://blog.photofeeler.com/wp-content/uploads/2017/02/flattering-pose-profile-pics.jpeg",
              //   name: "Sana Afzal",
              //   orderNo: "21893242380430",
              //   status: "Cancelled",
              //   statusColor: AppColors.rejected,
              //   dateTime:
              //       "Order placed on Wednesday, 21 May 2025 at 2:30 PM",
              //   price: "\$40.00",
              //   isDark: isDark,
              // ),
              // OrderCardWidget(
              //   imageUrl:
              //       "https://blog.photofeeler.com/wp-content/uploads/2017/02/flattering-pose-profile-pics.jpeg",
              //   name: "Sana Afzal",
              //   orderNo: "21893242380430",
              //   status: "Packed",
              //   statusColor: AppColors.lightblue,
              //   dateTime:
              //       "Order placed on Wednesday, 21 May 2025 at 2:30 PM",
              //   price: "\$40.00",
              //   isDark: isDark,
              // ),
              Obx(
                () =>
                    (c.isLoading.value)
                        ? SizedBox(
                          height: 100,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                        : c.allOrderLists.isEmpty
                        ? SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                              "No orders",
                              style: CustomTextStyles.f14W400(
                                color: AppColors.textGreyColor,
                              ),
                            ),
                          ),
                        )
                        : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: c.allOrderLists.length,
                          itemBuilder: (context, index) {
                            final Orders orders = c.allOrderLists[index];
                            return OrderCardWidget(
                              isDark: isDark,
                              orders: orders,
                            );
                          },
                        ),
              ),
              Column(children: [Text("To Pay")]),
              // Column(
              //   children: [
              //     OrderCardWidget(
              //       imageUrl:
              //           "https://blog.photofeeler.com/wp-content/uploads/2017/02/flattering-pose-profile-pics.jpeg",
              //       name: "Sana Afzal",
              //       orderNo: "21893242380430",
              //       status: "Seller to pack",
              //       statusColor: AppColors.primaryColor,
              //       dateTime:
              //           "Order placed on Wednesday, 21 May 2025 at 2:30 PM",
              //       price: "\$40.00",
              //       isDark: isDark,
              //     ),
              //     OrderCardWidget(
              //       imageUrl:
              //           "https://blog.photofeeler.com/wp-content/uploads/2017/02/flattering-pose-profile-pics.jpeg",
              //       name: "Sana Afzal",
              //       orderNo: "21893242380430",
              //       status: "Packed",
              //       statusColor: AppColors.lightblue,
              //       dateTime:
              //           "Order placed on Wednesday, 21 May 2025 at 2:30 PM",
              //       price: "\$40.00",
              //       isDark: isDark,
              //     ),
              //   ],
              // ),
              // Column(
              //   children: [
              //     OrderCardWidget(
              //       imageUrl:
              //           "https://blog.photofeeler.com/wp-content/uploads/2017/02/flattering-pose-profile-pics.jpeg",
              //       name: "Sana Afzal",
              //       orderNo: "21893242380430",
              //       status: "Delivered",
              //       statusColor: AppColors.accepted,
              //       dateTime:
              //           "Order placed on Wednesday, 21 May 2025 at 2:30 PM",
              //       price: "\$40.00",
              //       isDark: isDark,
              //     ),
              //   ],
              // ),
              // Column(
              //   children: [
              //     OrderCardWidget(
              //       imageUrl:
              //           "https://blog.photofeeler.com/wp-content/uploads/2017/02/flattering-pose-profile-pics.jpeg",
              //       name: "Sana Afzal",
              //       orderNo: "21893242380430",
              //       status: "Cancelled",
              //       statusColor: AppColors.redColor,
              //       dateTime:
              //           "Order placed on Wednesday, 21 May 2025 at 2:30 PM",
              //       price: "\$40.00",
              //       isDark: isDark,
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
