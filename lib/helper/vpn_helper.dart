// ignore_for_file: implementation_imports

import 'dart:math';
import 'package:darkfire_vpn/common/snackbar.dart';
import 'package:darkfire_vpn/controllers/subscription_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads/src/ad_instance_manager.dart';
import 'package:in_app_update/in_app_update.dart';

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

extension CheckProForAd on AdWithoutView {
  Future<void> showIfNotPro() async {
    if (!SubscriptionController.find.isPro) {
      await instanceManager.showAdWithoutView(this);
    }
  }
}

Future<bool> checkUpdate() async {
  showLoading();
  try {
    var info = await InAppUpdate.checkForUpdate();
    dismiss();
    if (info.updateAvailability == UpdateAvailability.updateAvailable) {
      if (info.flexibleUpdateAllowed) {
        InAppUpdate.startFlexibleUpdate().then((value) {
          InAppUpdate.completeFlexibleUpdate();
        });
      }
      if (info.immediateUpdateAllowed) {
        InAppUpdate.performImmediateUpdate();
      }
      return true;
    }
  } catch (_) {}
  dismiss();
  return false;
}

String getFormatedTime(int seconds) {
  // format time from seconds to 00:00:00
  int hours = (seconds / 3600).floor();
  int minutes = ((seconds % 3600) / 60).floor();
  int sec = (seconds % 60).floor();

  String hoursStr = (hours < 10) ? '0$hours' : hours.toString();
  String minStr = (minutes < 10) ? '0$minutes' : minutes.toString();
  String secStr = (sec < 10) ? '0$sec' : sec.toString();
  return '$hoursStr:$minStr:$secStr';
}
