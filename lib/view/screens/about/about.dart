import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:darkfire_vpn/utils/style.dart';
import 'package:darkfire_vpn/view/base/appBar.dart';
import 'package:darkfire_vpn/view/base/map_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MapBackground(),
          Column(
            children: [
              CustomAppBar(text: 'about'.tr, premium: true),
              Expanded(
                child: Padding(
                  padding: pagePadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.width * 0.75,
                        padding: pagePadding,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20.sp),
                          border:
                              Border.all(color: Theme.of(context).dividerColor),
                          boxShadow: boxShadow,
                        ),
                        child: Column(
                          children: [
                            Image.asset(Images.logo, width: 90.sp),
                            SizedBox(height: 16.sp),
                            Text(
                              AppConstants.APP_NAME,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16.sp),
                            Text(
                              '${'version'.tr} ${AppConstants.APP_VERSION}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: Theme.of(context).hintColor),
                            ),
                            SizedBox(height: 16.sp),
                            Text(
                              '''Unlock and Secure your online privacy with our VPN app. Our VPN ensures fast and secure browsing with a single tap. Stay protected, explore freely.''',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text(
                      'privacy_policy'.tr,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor,
                            color: primaryColor,
                          ),
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(width: 16.sp),
                  TextButton(
                    child: Text(
                      'terms_of_service'.tr,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor,
                            color: primaryColor,
                          ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Text(
                "Copyright 2014 - 2024.  All right Reserved",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SafeArea(child: SizedBox()),
            ],
          )
        ],
      ),
    );
  }
}
