import 'dart:io';
import 'package:darkfire_vpn/common/navigation.dart';
import 'package:darkfire_vpn/controllers/theme_controller.dart';
import 'package:darkfire_vpn/utils/colors.dart';
import 'package:darkfire_vpn/view/base/rating_widget.dart';
import 'package:darkfire_vpn/view/screens/about/about.dart';
import 'package:darkfire_vpn/view/screens/language/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../controllers/localization_controller.dart';
import '../../../helper/vpn_helper.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/style.dart';
import '../../base/appVersion_widget.dart';
import '../../base/updateNotAvailableDialog.dart';
import '../speed_test/speed_test.dart';
import '../split_tunnel/split_tunnel.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: Get.back,
        ),
        title: Text('menu'.tr),
      ),
      body: Column(
        children: [
          MenuTile(
            text: 'dark_theme',
            icon: Iconsax.moon,
            theme: true,
            onTap: ThemeController.find.toggleTheme,
          ),
          if (Platform.isAndroid) ...[
            MenuTile(
              text: 'speed_test',
              icon: Iconsax.speedometer,
              onTap: () => launchScreen(const SpeedTestScreen()),
            ),
            MenuTile(
              text: 'split_tunnel',
              icon: Iconsax.setting_4,
              onTap: () => launchScreen(const SplitTunnelScreen()),
            ),
          ],
          MenuTile(
            text: 'languages',
            icon: Iconsax.language_circle,
            onTap: () => Get.bottomSheet(const LanguageSheet()),
          ),
          MenuTile(
            text: 'check_update',
            icon: Iconsax.cloud_change,
            onTap: () => _checkUpdate(),
          ),
          MenuTile(
            text: 'privacy_policy',
            icon: Iconsax.shield_tick,
            onTap: () => launchUrlString(AppConstants.appPrivacyPolicyUrl),
          ),
          MenuTile(
            text: 'terms_of_service',
            icon: Iconsax.document,
            onTap: () => launchUrlString(AppConstants.appTermsAndConditionsUrl),
          ),
          MenuTile(
            text: 'about',
            icon: Iconsax.info_circle,
            onTap: () => launchScreen(const AboutScreen()),
          ),
          MenuTile(
            text: 'rate_us',
            icon: Iconsax.star,
            onTap: () => Get.dialog(
              Dialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 30.sp),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Container(
                  padding: pagePadding,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  child: const RatingWidget(),
                ),
              ),
            ),
          ),
          SizedBox(height: 32.sp),
          const AppVersionWidget(),
        ],
      ),
    );
  }

  ///Check for update when user click on the update button
  void _checkUpdate() async {
    if (Platform.isAndroid) {
      checkUpdate().then((value) {
        if (!value) {
          Get.dialog(const Updatenotavailabledialog());
        }
      });
    } else {
      launchUrlString("https://apps.apple.com/app/id${AppConstants.iosAppID}");
    }
  }
}

class MenuTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onTap;
  final bool theme;
  const MenuTile(
      {required this.text,
      required this.icon,
      this.onTap,
      this.theme = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // bottom border
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: primaryColor, size: 20.sp),
        title: Text(
          text.tr,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        onTap: onTap,
        trailing: theme
            ? GetBuilder<ThemeController>(
                builder: (theme) {
                  return Switch(
                    value: theme.darkTheme,
                    onChanged: (value) {
                      theme.toggleTheme();
                    },
                  );
                },
              )
            : GetBuilder<LocalizationController>(builder: (con) {
                IconData ltrIcon = Iconsax.arrow_right_3;
                IconData rtlIcon = Iconsax.arrow_left_2;
                return Icon(con.isLtr ? ltrIcon : rtlIcon, size: 18.sp);
              }),
        visualDensity: const VisualDensity(horizontal: -4, vertical: -3),
      ),
    );
  }
}
