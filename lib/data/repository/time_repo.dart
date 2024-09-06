import 'dart:convert';
import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeRepo {
  final SharedPreferences sharedPreferences;
  TimeRepo({required this.sharedPreferences});

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
}
