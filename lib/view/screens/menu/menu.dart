import 'dart:io';
import 'package:darkfire_vpn/common/navigation.dart';
import 'package:darkfire_vpn/controllers/theme_controller.dart';
import 'package:darkfire_vpn/utils/colors.dart';
import 'package:darkfire_vpn/view/screens/about/about.dart';
import 'package:darkfire_vpn/view/screens/language/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../helper/vpn_helper.dart';
import '../../../utils/app_constants.dart';
import '../../base/updateNotAvailableDialog.dart';
import '../speed_test/speed_test.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

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
          MenuTile(
            text: 'speed_test',
            icon: Iconsax.speedometer,
            onTap: () => launchScreen(const SpeedTestScreen()),
          ),
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
            onTap: () {},
          ),
          MenuTile(
            text: 'terms_of_service',
            icon: Iconsax.document,
            onTap: () {},
          ),
          MenuTile(
            text: 'about',
            icon: Iconsax.info_circle,
            onTap: () => launchScreen(const AboutScreen()),
          ),
          SizedBox(height: 32.sp),
          Text(
            '${'version'.tr} ${AppConstants.APP_VERSION}',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Theme.of(context).hintColor),
          ),
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
            : Icon(Iconsax.arrow_right_3, size: 20.sp),
        visualDensity: const VisualDensity(horizontal: -4, vertical: -3),
      ),
    );
  }
}
