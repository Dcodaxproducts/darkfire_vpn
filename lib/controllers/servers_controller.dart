import 'dart:convert';
import 'package:darkfire_vpn/common/snackbar.dart';
import 'package:darkfire_vpn/data/model/response/ip_address.dart';
import 'package:darkfire_vpn/data/repository/server_repo.dart';
import 'package:get/get.dart';
import '../data/model/body/vpn_config.dart';

class ServerController extends GetxController implements GetxService {
  final ServerRepo serverRepo;
  ServerController({required this.serverRepo});
  static ServerController get find => Get.find<ServerController>();

  static ServerController get to => Get.find<ServerController>();

  bool _loading = false;
  List<VpnConfig> _allServers = [];
  List<VpnConfig> _freeServers = [];
  List<VpnConfig> _proServers = [];
  IpAddressModel? _publicIP;

  bool get loading => _loading;
  List<VpnConfig> get allServers => _allServers;
  List<VpnConfig> get freeServers => _freeServers;
  List<VpnConfig> get proServers => _proServers;
  IpAddressModel? get publicIP => _publicIP;

  set publicIP(IpAddressModel? value) {
    _publicIP = value;
    update();
  }

  set loading(bool value) {
    _loading = value;
    update();
  }

  Future<void> getAllServers() async {
    loading = true;
    final response = await serverRepo.getAllServers();
    if (response != null) {
      final data = jsonDecode(response.body)['data'];
      _allServers =
          List<VpnConfig>.from(data.map((x) => VpnConfig.fromJson(x)));
      loading = false;
    }
  }

  Future<VpnConfig?> getServerDetails(String server) async {
    showLoading();
    final response = await serverRepo.getServerDetail(server);
    if (response != null) {
      final data = jsonDecode(response.body)['data'];
      return VpnConfig.fromJson(data);
    }
    return null;
  }

  Future<void> getAllFreeServers() async {
    final response = await serverRepo.getAllFreeServers();
    if (response != null) {
      final data = jsonDecode(response.body)['data'];
      _freeServers =
          List<VpnConfig>.from(data.map((x) => VpnConfig.fromJson(x)));
      update();
    }
  }

  Future<void> getAllProServers() async {
    final response = await serverRepo.getAllProServers();
    if (response != null) {
      final data = jsonDecode(response.body)['data'];
      _proServers =
          List<VpnConfig>.from(data.map((x) => VpnConfig.fromJson(x)));
      update();
    }
  }

  Future<VpnConfig> getRandomServer() async {
    final response = await serverRepo.getRandomServer();
    VpnConfig? randomServer;
    if (response != null) {
      final data = jsonDecode(response.body)['data'];
      randomServer = VpnConfig.fromJson(data);
    }
    return randomServer!;
  }

  Future<void> getPublicIP() async {
    final response = await serverRepo.getPublicIP();
    if (response != null) {
      final data = jsonDecode(response.body);
      publicIP = IpAddressModel.fromJson(data);
    }
  }
}
