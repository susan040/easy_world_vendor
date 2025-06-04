import 'package:easy_world_vendor/controller/splash_screen_controller.dart';
import 'package:easy_world_vendor/utils/colors.dart';
import 'package:easy_world_vendor/utils/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  final c = Get.put(SplashScreenController());
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.extraWhite,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 170),
              Image.asset(ImagePath.logo, height: 220, width: 220),
              Expanded(
                child: SpinKitFadingCircle(
                  color: AppColors.secondaryColor,
                  size: 45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
