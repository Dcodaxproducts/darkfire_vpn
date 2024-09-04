// ignore_for_file: deprecated_member_use, avoid_print

import 'package:darkfire_vpn/root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'common/loading.dart';
import 'controllers/localization_controller.dart';
import 'controllers/theme_controller.dart';
import 'firebase_options.dart';
import 'helper/get_di.dart' as di;
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'utils/app_constants.dart';
import 'utils/messages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Map<String, Map<String, String>> languages = await di.init();
  FirebaseMessaging.instance.requestPermission();
  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({required this.languages, super.key});

  @override
  Widget build(BuildContext context) {
    // Example criteria for device type detection
    final bool isTablet = MediaQuery.of(context).size.shortestSide > 600;
    final bool isLargeTablet = MediaQuery.of(context).size.shortestSide > 800;
    // Define designSizes for different devices
    Size designSize;
    if (isLargeTablet) {
      designSize = const Size(1024, 1366); // Example for large tablets
    } else if (isTablet) {
      designSize = const Size(768, 1024); // Example for regular tablets
    } else {
      designSize = const Size(411.4, 866.3); // Example for phones
    }
    return GetBuilder<LocalizationController>(builder: (localizeController) {
      return GetBuilder<ThemeController>(
        builder: (themeController) {
          return ScreenUtilInit(
            designSize: designSize,
            minTextAdapt: true,
            splitScreenMode: true,
            fontSizeResolver: (size, util) =>
                _screenSize(size, isTablet, isLargeTablet, util),
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor:
                    MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.22),
              ),
              child: GetMaterialApp(
                title: AppConstants.APP_NAME,
                debugShowCheckedModeBanner: false,
                themeMode: themeController.themeMode,
                theme: light(),
                darkTheme: dark(),
                locale: localizeController.locale,
                translations: Messages(languages: languages),
                fallbackLocale: Locale(
                  AppConstants.languages[0].languageCode,
                  AppConstants.languages[0].countryCode,
                ),
                navigatorObservers: [FlutterSmartDialog.observer],
                builder: FlutterSmartDialog.init(
                    loadingBuilder: (string) => const Loading()),
                home: const Root(),
              ),
            ),
          );
        },
      );
    });
  }

  double _screenSize(size, isTablet, isLargeTablet, util) {
    double scaleFactor = 1.0;
    if (isTablet || isLargeTablet) {
      scaleFactor = 1.0;
    } else {
      scaleFactor = util.scaleText;
    }
    return size * scaleFactor;
  }
}
