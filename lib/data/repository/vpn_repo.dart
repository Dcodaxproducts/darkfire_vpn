import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/body/vpn_config.dart';

class VpnRepo {
  final SharedPreferences sharedPreferences;
  VpnRepo({required this.sharedPreferences});

  void saveServers({required List<VpnConfig> value}) {
    sharedPreferences.setString(
        "server_cache", jsonEncode(value.map((e) => e.toJson()).toList()));
  }

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

  List<VpnConfig> loadServers() {
    var data = sharedPreferences.getString("server_cache");
    if (data != null) {
      return (jsonDecode(data) as List)
          .map((e) => VpnConfig.fromJson(e))
          .toList();
    }
    return [];
  }
}
