import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:darkfire_vpn/utils/images.dart';
import 'package:darkfire_vpn/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/splash_controller.dart';
import '../../base/map_background.dart';
import '../../base/progressBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController get _splashController => SplashController.find;

  @override
  void initState() {
    super.initState();
    _splashController.initSharedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const MapBackground(),
        Padding(
          padding: pagePadding,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // VPN Icon (replace with your shield icon if needed)
                    Image.asset(Images.logo, width: 150.sp),
                    SizedBox(height: 150.sp),
                    // VPN Title
                    Text(
                      AppConstants.APP_NAME,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.sp),
                    // VPN, Subtitle
                    Text(
                      'secure_your_digital_journey'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Theme.of(context).hintColor),
                    ),
                    SizedBox(height: 50.sp),
                  ],
                ),
              ),
              const AnimatedProgressBar(duration: Duration(seconds: 3)),
              SizedBox(height: 10.sp),
              Text(
                'connecting_securely'.tr,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).hintColor),
              ),
              SizedBox(height: 32.sp),
            ],
          ),
        ),
      ],
    ));
  }
}
