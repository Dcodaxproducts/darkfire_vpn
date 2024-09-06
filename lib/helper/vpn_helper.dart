// ignore_for_file: implementation_imports

import 'dart:convert';
import 'dart:math';
import 'package:darkfire_vpn/common/snackbar.dart';
import 'package:darkfire_vpn/controllers/iap_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_mobile_ads/src/ad_instance_manager.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)}  ${suffixes[i]}';
}

extension CheckProForAd on AdWithoutView {
  void showIfNotPro() {
    if (IAPController.find.isPro) {
      instanceManager.showAdWithoutView(this);
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

/* VPN disconnection */
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // This is the background task that will disconnect the VPN
    if (task == 'vpn_disconnection_task') {
      // Logic to disconnect the VPN
      OpenVPN().disconnect();
      resetExtraTime();
      debugPrint("VPN disconnected from background task");
    }
    return Future.value(true);
  });
}

void resetExtraTime() async {
  final pref = await SharedPreferences.getInstance();
  pref.setString(
    'extra_time',
    jsonEncode(
      {'remainingTimeInSeconds': 0, 'lastExtraTimeGiven': null},
    ),
  );
}

appCloseDisconnectVPN() {
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
}
