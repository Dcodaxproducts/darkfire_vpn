import 'dart:developer';

import 'package:darkfire_vpn/common/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../controllers/iap_controller.dart';
import '../../utils/app_constants.dart';
import '../screens/menu/menu.dart';
import '../screens/subscription/subscription.dart';

class CustomAppBar extends StatelessWidget {
  final bool home;
  final String text;
  final bool premium;
  const CustomAppBar(
      {this.home = false,
      this.text = AppConstants.APP_NAME,
      this.premium = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 60.sp,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                if (home) {
                  launchScreen(const MenuScreen());
                } else {
                  pop();
                }
              },
              icon: Icon(home ? Icons.menu : Icons.arrow_back),
            ),
            SizedBox(width: 10.sp),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            if (!premium)
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  log(Get.currentRoute.toString());
                  launchScreen(const SubscriptionScreen());
                },
                icon: GetBuilder<IAPController>(
                  builder: (value) => LottieBuilder.asset(
                    "assets/animations/crown_${value.isPro ? "pro" : "free"}.json",
                    width: 42.sp,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
