import 'dart:convert';
import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class TimeRepo {
  final SharedPreferences sharedPreferences;
  final Workmanager workmanager;
  TimeRepo({required this.sharedPreferences, required this.workmanager});

  Future<bool> saveExtraTime(Map<String, dynamic> data) async {
    return sharedPreferences.setString(
        AppConstants.EXTRA_TIME, jsonEncode(data));
  }

  Map<String, dynamic> getExtraTime() {
    String? data = sharedPreferences.getString(AppConstants.EXTRA_TIME);
    if (data == null) {
      return {};
    }
    return jsonDecode(data);
  }

  void scheduleVpnDisconnection(int deleySeconds) async {
    // Schedule the VPN disconnection when remaining time reaches zero
    workmanager.registerOneOffTask(
      AppConstants.VPN_DISCONNECT_TASK,
      AppConstants.VPN_DISCONNECT_TASK,
      initialDelay: Duration(seconds: deleySeconds),
    );
  }

  Future<void> cancelTask() async {
    await workmanager.cancelByUniqueName(AppConstants.VPN_DISCONNECT_TASK);
  }
}
