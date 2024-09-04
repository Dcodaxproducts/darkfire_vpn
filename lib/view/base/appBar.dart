import 'package:darkfire_vpn/common/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../controllers/iap_provider.dart';
import '../../utils/app_constants.dart';
import '../screens/menu/menu.dart';

class CustomAppBar extends StatelessWidget {
  final bool home;
  final String text;
  const CustomAppBar(
      {this.home = false, this.text = AppConstants.APP_NAME, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 60,
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
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => _upgradeProClick(context),
              icon: GetBuilder<IAPController>(
                builder: (value) => LottieBuilder.asset(
                  "assets/animations/crown_${value.isPro ? "pro" : "free"}.json",
                  width: 50.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///Open the subscription screen when user click on the crown icon
  void _upgradeProClick(BuildContext context) {
    // startScreen(context, const SubscriptionScreen());
  }
}
