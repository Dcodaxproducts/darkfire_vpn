import 'package:darkfire_vpn/data/api/api_client.dart';
import 'package:http/http.dart';

class ServerRepo {
  final ApiClient apiClient;
  ServerRepo({required this.apiClient});

  Future<Response?> getAllServers() async {
    return await apiClient.getData("allservers");
  }

  Future<Response?> getServerDetail(String server) async {
    return await apiClient.getData("detail/$server");
  }

  Future<Response?> getAllFreeServers() async {
    return await apiClient.getData("allservers/free");
  }

  Future<Response?> getAllProServers() async {
    return await apiClient.getData("allservers/pro");
  }

  Future<Response?> getRandomServer() async {
    return await apiClient.getData("detail/random");
  }

  Future<Response?> getPublicIP() async {
    return await apiClient.getData("https://myip.wtf/json", uriOnly: true);
  }
}
