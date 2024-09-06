import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/body/vpn_config.dart';

class VpnRepo {
  final SharedPreferences sharedPreferences;
  VpnRepo({required this.sharedPreferences});

  void setServer(VpnConfig? value) {
    if (value == null) {
      sharedPreferences.remove("server");
      return;
    }
    sharedPreferences.setString("server", jsonEncode(value.toJson()));
  }

  VpnConfig? getServer() {
    final server = sharedPreferences.getString("server");
    if (server != null) {
      return VpnConfig.fromJson(jsonDecode(server));
    }
    return null;
  }
}
