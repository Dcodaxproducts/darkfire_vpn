import 'dart:developer';
import 'package:darkfire_vpn/common/navigation.dart';
import 'package:darkfire_vpn/controllers/servers_controller.dart';
import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import '../data/model/body/vpn_config.dart';
import '../data/repository/vpn_repo.dart';

class VpnController extends GetxController implements GetxService {
  final VpnRepo vpnRepo;
  VpnController({required this.vpnRepo});

  static VpnController get find => Get.find<VpnController>();

  String? vpnStage;
  VpnStatus? vpnStatus;
  VpnConfig? _vpnConfig;
  bool _showConnectedView = false;

  VpnConfig? get vpnConfig => _vpnConfig;
  bool get showConnectedView => _showConnectedView;

  set vpnConfig(VpnConfig? value) {
    _vpnConfig = value;
    vpnRepo.setServer(value);
    update();
  }

  set showConnectedView(bool value) {
    _showConnectedView = value;
    update();
  }

  ///VPN engine
  late OpenVPN engine;

  ///Check if VPN is connected
  bool get isConnected =>
      vpnStage?.toLowerCase() == VPNStage.connected.name.toLowerCase();

  ///Initialize VPN engine and load last server
  Future<void> initialize() async {
    log("====> VPN Controller Initialized");
    engine = OpenVPN(
        onVpnStageChanged: onVpnStageChanged,
        onVpnStatusChanged: onVpnStatusChanged)
      ..initialize(
        lastStatus: onVpnStatusChanged,
        lastStage: (stage) => onVpnStageChanged(stage, stage.name),
        groupIdentifier: AppConstants.groupIdentifier,
        localizedDescription: AppConstants.localizationDescription,
        providerBundleIdentifier: AppConstants.providerBundleIdentifier,
      );

    vpnConfig =
        vpnRepo.getServer() ?? await ServerController.find.getRandomServer();
    update();
  }

  ///VPN status changed
  void onVpnStatusChanged(VpnStatus? status) {
    vpnStatus = status;
    update();
  }

  ///VPN stage changed
  void onVpnStageChanged(VPNStage stage, String rawStage) {
    vpnStage = rawStage;
    if (stage == VPNStage.error) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        vpnStage = rawStage;
      });
    }
    update();
    if (vpnStage == "connected") {
      Future.delayed(const Duration(milliseconds: 1500)).then((value) {
        showConnectedView = true;
      });
    }
  }

  ///Connect to VPN server
  void connect() async {
    String? config;
    try {
      config = await OpenVPN.filteredConfig(vpnConfig?.config);
    } catch (e) {
      config = vpnConfig?.config;
    }
    if (config == null) return;
    engine.connect(
      config,
      vpnConfig!.name,
      certIsRequired: AppConstants.certificateVerify,
      username: vpnConfig!.username ?? AppConstants.vpnUsername,
      password: vpnConfig!.password ?? AppConstants.vpnPassword,
    );
  }

  ///Select server from list
  Future<void> selectServer(BuildContext context, VpnConfig config) async {
    return ServerController.find.getServerDetails(config.slug).then((value) {
      if (value != null) {
        pop();
        vpnConfig = value;
        update();
      }
    });
  }

  ///Disconnect from VPN server if connected
  void disconnect(
      Function(VpnStatus vpnStatus, VpnConfig vpnConfig) onDisconnect) {
    VpnStatus status = vpnStatus!;
    VpnConfig config = vpnConfig!;
    engine.disconnect();
    onDisconnect.call(status, config);
    Future.delayed(const Duration(milliseconds: 500), () {
      showConnectedView = false;
    });
  }
}
