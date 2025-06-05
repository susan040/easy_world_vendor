import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/custom_text_style.dart';
import 'package:easy_world_vendor/widgets/order_screen_widget.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

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
              Column(
                children: [
                  OrderCardWidget(
                    imageUrl:
                        "https://blog.photofeeler.com/wp-content/uploads/2017/02/flattering-pose-profile-pics.jpeg",
                    name: "Sana Afzal",
                    orderNo: "21893242380430",
                    status: "Processing",
                    statusColor: AppColors.primaryColor,
                    statusBgColor: AppColors.primeYellow.withOpacity(0.5),
                    dateTime:
                        "Order placed on Wednesday, 21 May 2025 at 2:30 PM",
                    price: "\$40.00",
                    isDark: isDark,
                  ),
                  OrderCardWidget(
                    imageUrl:
                        "https://blog.photofeeler.com/wp-content/uploads/2017/02/flattering-pose-profile-pics.jpeg",
                    name: "Sana Afzal",
                    orderNo: "21893242380430",
                    status: "Delivered",
                    statusColor: AppColors.accepted,
                    statusBgColor: AppColors.green.withOpacity(0.4),
                    dateTime:
                        "Order placed on Wednesday, 21 May 2025 at 2:30 PM",
                    price: "\$40.00",
                    isDark: isDark,
                  ),
                  OrderCardWidget(
                    imageUrl:
                        "https://blog.photofeeler.com/wp-content/uploads/2017/02/flattering-pose-profile-pics.jpeg",
                    name: "Sana Afzal",
                    orderNo: "21893242380430",
                    status: "Cancelled",
                    statusColor: AppColors.redColor,
                    statusBgColor: AppColors.rejected.withOpacity(0.4),
                    dateTime:
                        "Order placed on Wednesday, 21 May 2025 at 2:30 PM",
                    price: "\$40.00",
                    isDark: isDark,
                  ),
                  OrderCardWidget(
                    imageUrl:
                        "https://blog.photofeeler.com/wp-content/uploads/2017/02/flattering-pose-profile-pics.jpeg",
                    name: "Sana Afzal",
                    orderNo: "21893242380430",
                    status: "Shipped",
                    statusColor: AppColors.lightblue,
                    statusBgColor: AppColors.skyBlue.withOpacity(0.4),
                    dateTime:
                        "Order placed on Wednesday, 21 May 2025 at 2:30 PM",
                    price: "\$40.00",
                    isDark: isDark,
                  ),
                ],
              ),

              Column(children: [Text("To Pay")]),
              Column(children: [Text("To Ship")]),
              Column(
                children: [
                  OrderCardWidget(
                    imageUrl:
                        "https://blog.photofeeler.com/wp-content/uploads/2017/02/flattering-pose-profile-pics.jpeg",
                    name: "Sana Afzal",
                    orderNo: "21893242380430",
                    status: "Delivered",
                    statusColor: AppColors.accepted,
                    statusBgColor: AppColors.green.withOpacity(0.4),
                    dateTime:
                        "Order placed on Wednesday, 21 May 2025 at 2:30 PM",
                    price: "\$40.00",
                    isDark: isDark,
                  ),
                ],
              ),
              Column(
                children: [
                  OrderCardWidget(
                    imageUrl:
                        "https://blog.photofeeler.com/wp-content/uploads/2017/02/flattering-pose-profile-pics.jpeg",
                    name: "Sana Afzal",
                    orderNo: "21893242380430",
                    status: "Cancelled",
                    statusColor: AppColors.redColor,
                    statusBgColor: AppColors.rejected.withOpacity(0.4),
                    dateTime:
                        "Order placed on Wednesday, 21 May 2025 at 2:30 PM",
                    price: "\$40.00",
                    isDark: isDark,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
