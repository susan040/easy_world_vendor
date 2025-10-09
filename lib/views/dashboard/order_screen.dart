import 'package:easy_world_vendor/controller/dashboard/order_screen_controller.dart';
import 'package:easy_world_vendor/models/orders.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/widgets/order_filter_widget.dart';
import 'package:easy_world_vendor/widgets/order_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

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
          actions: [
            InkWell(
              onTap: () {
                Get.bottomSheet(
                  OrderFilterSheet(
                    onFilterSelected: (start, end) {
                      if (start.year <= 2000) {
                        c.clearDateFilter();
                      } else {
                        c.filterOrdersByDate(start, end);
                      }
                    },
                  ),
                  isScrollControlled: true,
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.filter_list,
                    size: 20,
                    color: isDark ? AppColors.extraWhite : AppColors.blackColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 18),
                    child: Text(
                      "Filter",
                      style: CustomTextStyles.f12W600(
                        color:
                            isDark
                                ? AppColors.extraWhite
                                : AppColors.blackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
              Obx(() {
                if (c.isLoading.value) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 14,
                        right: 14,
                        top: 10,
                      ),
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
                              margin: const EdgeInsets.only(bottom: 10),
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  );
                } else if (c.filteredOrderLists.isEmpty) {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        "No orders",
                        style: CustomTextStyles.f14W400(
                          color: AppColors.textGreyColor,
                        ),
                      ),
                    ),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await c.getAllOrders();
                      ;
                    },
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: c.filteredOrderLists.length,
                      itemBuilder: (context, index) {
                        final Orders orders = c.filteredOrderLists[index];
                        return OrderCardWidget(isDark: isDark, orders: orders);
                      },
                    ),
                  );
                }
              }),
              Obx(() {
                if (c.isLoading.value) {
                  return SizedBox(
                    height: 100,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                final pendingOrders =
                    c.allOrderLists
                        .where(
                          (order) =>
                              (order.status ?? "").toLowerCase() == "pending",
                        )
                        .toList();

                if (pendingOrders.isEmpty) {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        "No pending orders",
                        style: CustomTextStyles.f14W400(
                          color: AppColors.textGreyColor,
                        ),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: pendingOrders.length,
                  itemBuilder: (context, index) {
                    final Orders orders = pendingOrders[index];
                    return OrderCardWidget(isDark: isDark, orders: orders);
                  },
                );
              }),

              Obx(() {
                if (c.isLoading.value) {
                  return SizedBox(
                    height: 100,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                final filteredOrders =
                    c.allOrderLists.where((order) {
                      final status = (order.status ?? "").toLowerCase();
                      return status == "seller to pack" || status == "packed";
                    }).toList();

                if (filteredOrders.isEmpty) {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        "No shipping orders",
                        style: CustomTextStyles.f14W400(
                          color: AppColors.textGreyColor,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final Orders orders = filteredOrders[index];
                    return OrderCardWidget(isDark: isDark, orders: orders);
                  },
                );
              }),
              Obx(() {
                if (c.isLoading.value) {
                  return SizedBox(
                    height: 100,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                final filteredOrders =
                    c.allOrderLists.where((order) {
                      final status = (order.status ?? "").toLowerCase();
                      return status == "in transit" || status == "to receive";
                    }).toList();

                if (filteredOrders.isEmpty) {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        "No orders to receive",
                        style: CustomTextStyles.f14W400(
                          color: AppColors.textGreyColor,
                        ),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final Orders orders = filteredOrders[index];
                    return OrderCardWidget(isDark: isDark, orders: orders);
                  },
                );
              }),
              Obx(() {
                if (c.isLoading.value) {
                  return SizedBox(
                    height: 100,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                final filteredOrders =
                    c.allOrderLists.where((order) {
                      final status = (order.status ?? "").toLowerCase();
                      return status == "cancelled";
                    }).toList();

                if (filteredOrders.isEmpty) {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        "No cancelled orders",
                        style: CustomTextStyles.f14W400(
                          color: AppColors.textGreyColor,
                        ),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final Orders orders = filteredOrders[index];
                    return OrderCardWidget(isDark: isDark, orders: orders);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
