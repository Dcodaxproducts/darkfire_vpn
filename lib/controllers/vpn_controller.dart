import 'package:darkfire_vpn/common/navigation.dart';
import 'package:darkfire_vpn/controllers/servers_controller.dart';
import 'package:darkfire_vpn/controllers/time_controller.dart';
import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import '../data/model/body/vpn_config.dart';
import '../data/repository/vpn_repo.dart';
import '../helper/vpn_helper.dart';
import '../view/screens/report/report.dart';

class VpnController extends GetxController implements GetxService {
  final VpnRepo vpnRepo;
  VpnController({required this.vpnRepo});

  static VpnController get find => Get.find<VpnController>();

  String? vpnStage;
  VpnStatus? vpnStatus;
  VpnConfig? _vpnConfig;
  bool _showConnectedView = false;
  String _remainingTime = "00:00:00";

  VpnConfig? get vpnConfig => _vpnConfig;
  bool get showConnectedView => _showConnectedView;
  String get remainingTime => _remainingTime;

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
    TimeController.find.loadExtraTime();
    engine = OpenVPN(
      onVpnStageChanged: onVpnStageChanged,
      onVpnStatusChanged: onVpnStatusChanged,
    )..initialize(
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
    if (status != null && status.duration != "00:00:00") {
      int time = TimeController.find.updateRemainingTime(status);
      _remainingTime = getFormatedTime(time);
    }
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
    if (vpnStage == "disconnected" && _showConnectedView) {
      disconnect((vpnStatus, vpnConfig) {
        if (Get.currentRoute == "/server") {
          pop();
          return;
        }
        launchScreen(
          ReportScreen(vpnStatus: vpnStatus, vpnConfig: vpnConfig),
        );
      });
    }
  }

  ///Connect to VPN server
  void connect() async {
    TimeController.find.loadExtraTime();
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
  Future<void> selectServer(VpnConfig config, {Function()? callback}) async {
    return ServerController.find.getServerDetails(config.slug).then((value) {
      if (value != null) {
        pop();
        vpnConfig = value;
        update();
        callback?.call();
      }
    });
  }

  ///Disconnect from VPN server if connected
  void disconnect(
      Function(VpnStatus vpnStatus, VpnConfig vpnConfig) onDisconnect) {
    TimeController.find.cancelTask();
    if (vpnStatus == null || vpnConfig == null) return;
    VpnStatus status = vpnStatus!;
    VpnConfig config = vpnConfig!;
    engine.disconnect();
    onDisconnect.call(status, config);
    Future.delayed(const Duration(milliseconds: 500), () {
      showConnectedView = false;
    });
  }
}
