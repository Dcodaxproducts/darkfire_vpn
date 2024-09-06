import 'dart:convert';
import 'package:darkfire_vpn/data/api/api_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/body/vpn_config.dart';

class ServerRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ServerRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response?> getAllServers() async {
    return await apiClient.getData("allservers");
  }

  Future<Response?> getServerDetail(String server) async {
    return await apiClient.getData("detail/$server");
  }

  void saveServers({required List<VpnConfig> value}) {
    sharedPreferences.setString(
        "server_cache", jsonEncode(value.map((e) => e.toJson()).toList()));
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

  Future<Response?> getRandomServer() async {
    return await apiClient.getData("detail/random");
  }

  Future<Response?> getPublicIP() async {
    return await apiClient.getData("https://myip.wtf/json", uriOnly: true);
  }
}
