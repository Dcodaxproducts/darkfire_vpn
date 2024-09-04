import 'dart:io';
import 'package:darkfire_vpn/controllers/theme_controller.dart';
import 'package:darkfire_vpn/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ndialog/ndialog.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../helper/vpn_helper.dart';
import '../../../utils/app_constants.dart';

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
        title: const Text('Menu'),
      ),
      body: Column(
        children: [
          const MenuTile(
            text: 'Dark Theme',
            icon: Iconsax.moon,
            theme: true,
          ),
          MenuTile(
            text: 'Languages',
            icon: Iconsax.language_circle,
            onTap: () => _aboutClick(),
          ),
          MenuTile(
            text: 'Check Update',
            icon: Iconsax.cloud_change,
            onTap: () => _checkUpdate(),
          ),
          MenuTile(
            text: 'Privacy Policy',
            icon: Iconsax.shield_tick,
            onTap: () => _aboutClick(),
          ),
          MenuTile(
            text: 'Terms of Service',
            icon: Iconsax.document,
            onTap: () => _aboutClick(),
          ),
          MenuTile(
            text: 'About',
            icon: Iconsax.info_circle,
            onTap: () => _aboutClick(),
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
          NAlertDialog(
            title: const Text("update_not_available"),
            content: const Text("update_not_available_content"),
            blur: 10,
            actions: [
              TextButton(
                onPressed: Get.back,
                child: const Text("close"),
              ),
            ],
          ).show(Get.context!);
        }
      });
    } else {
      launchUrlString("https://apps.apple.com/app/id${AppConstants.iosAppID}");
    }
  }

  ///Open the about dialog when user click on the about button
  void _aboutClick() {
    // const DialogBackground(dialog: AboutScreen(), blur: 10).show(context);
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
          text,
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
