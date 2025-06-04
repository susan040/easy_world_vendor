import 'package:easy_world_vendor/views/dashboard/home_screen.dart';
import 'package:easy_world_vendor/views/dashboard/order_screen.dart';
import 'package:easy_world_vendor/views/dashboard/products_screen.dart';
import 'package:easy_world_vendor/views/dashboard/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashScreenController extends GetxController {
  final key = GlobalKey<ScaffoldState>();
  RxList<Widget> pages = RxList([
    HomeScreen(),
    OrderScreen(),
    ProductsScreen(),
    ProfileScreen(),
  ]);
  RxInt currentIndex = RxInt(0);
  void changeTab(int index) {
    currentIndex.value = index;
  }
}
