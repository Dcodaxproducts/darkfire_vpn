import 'package:darkfire_vpn/common/navigation.dart';
import 'package:darkfire_vpn/common/primary_button.dart';
import 'package:darkfire_vpn/controllers/splash_controller.dart';
import 'package:darkfire_vpn/root.dart';
import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:darkfire_vpn/utils/colors.dart';
import 'package:darkfire_vpn/utils/images.dart';
import 'package:darkfire_vpn/utils/style.dart';
import 'package:darkfire_vpn/view/base/map_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MapBackground(),
          Padding(
            padding: pagePadding.copyWith(bottom: 0),
            child: Column(
              children: [
                // Top part: Logo and title
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Center(
                        child: Image.asset(
                          Images.logo,
                          height: 150.sp,
                          width: 150.sp,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // App Name
                      Text(
                        AppConstants.APP_NAME,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                // Agree & Continue Button
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    text: 'Agree & Continue',
                    onPressed: () {
                      SplashController.find.saveFirstTime();
                      launchScreen(const Root(), pushAndRemove: true);
                    },
                  ),
                ),
                SizedBox(height: 16.sp),
                // Privacy Policy and Terms & Conditions Links
                Text.rich(
                  TextSpan(
                    text: 'By continuing, you agree to our ',
                    style: Theme.of(context).textTheme.bodySmall,
                    children: const [
                      TextSpan(
                        text: 'privacy policy',
                        style: TextStyle(
                          color: primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: primaryColor,
                        ),
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(
                          color: primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SafeArea(child: SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
