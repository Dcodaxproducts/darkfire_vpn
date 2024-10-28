import 'package:darkfire_vpn/common/navigation.dart';
import 'package:darkfire_vpn/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_constants.dart';
// import '../screens/subscription/subscription.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:darkfire_vpn/controllers/subscription_controller.dart';
// import 'dart:developer';

class CustomAppBar extends StatelessWidget {
  final bool home;
  final String text;
  final bool premium;
  final List<Widget> actions;
  const CustomAppBar(
      {this.home = false,
      this.text = AppConstants.APP_NAME,
      this.premium = false,
      this.actions = const [],
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
                  Scaffold.of(context).openDrawer();
                } else {
                  pop();
                }
              },
              icon: home
                  ? Image.asset(
                      Images.menu,
                      width: 20.sp,
                      height: 20.sp,
                      color: Theme.of(context).iconTheme.color,
                    )
                  : const Icon(Icons.arrow_back),
            ),
            SizedBox(width: 10.sp),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            ...actions,
            // if (!premium)
            //   IconButton(
            //     padding: EdgeInsets.zero,
            //     onPressed: () {
            //       log(Get.currentRoute.toString());
            //       launchScreen(const SubscriptionScreen());
            //     },
            //     icon: GetBuilder<SubscriptionController>(
            //       builder: (value) => Hero(
            //         tag: 'crown',
            //         child: LottieBuilder.asset(
            //           "assets/animations/crown_pro.json",
            //           width: 42.sp,
            //         ),
            //       ),
            //     ),
            //   )
          ],
        ),
      ),
    );
  }
}
