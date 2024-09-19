// ignore_for_file: implementation_imports

import 'dart:convert';
import 'dart:developer';
import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

Future<void> appCloseDisconnectVPN() async {
  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
}

/* VPN disconnection */
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // This is the background task that will disconnect the VPN
    if (task == AppConstants.VPN_DISCONNECT_TASK) {
      // disconnect VPN
      OpenVPN().disconnect();
      // reset extra time
      resetExtraTime();
      // show notification
      showVPNDisconnectNotification();
    }
    return Future.value(true);
  });
}

void resetExtraTime() async {
  Workmanager().cancelByUniqueName(AppConstants.VPN_DISCONNECT_TASK);
  final pref = await SharedPreferences.getInstance();
  pref.setString(
    'extra_time',
    jsonEncode(
      {'remainingTimeInSeconds': 0, 'lastExtraTimeGiven': null},
    ),
  );
}

showVPNDisconnectNotification() async {
  try {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = const DarwinInitializationSettings();
    var initSetttings = InitializationSettings(android: android, iOS: iOS);
    await flp.initialize(initSetttings);
    showNotification(flp);
  } catch (e) {
    log(e.toString());
  }
}

void showNotification(FlutterLocalNotificationsPlugin flp) async {
  var android = AndroidNotificationDetails(
    AppConstants.VPN_DISCONNECT_TASK,
    AppConstants.VPN_DISCONNECT_TASK,
    priority: Priority.high,
    importance: Importance.max,
  );
  var iOS = const DarwinNotificationDetails();
  var platform = NotificationDetails(android: android, iOS: iOS);
  await flp.show(
      0, 'VPN Disconnected', 'Your VPN connection has ended.', platform);
}
