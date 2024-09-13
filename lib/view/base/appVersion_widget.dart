import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/splash_controller.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (con) {
      return Visibility(
        visible: con.packageInfo != null,
        child: Text(
          '${'version'.tr} ${con.packageInfo?.version} (${con.packageInfo?.buildNumber})',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Theme.of(context).hintColor),
        ),
      );
    });
  }
}
