import 'package:get/get.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import '../data/repository/tunnel_repo.dart';

class SplitTunnelController extends GetxController implements GetxService {
  final TunnelRepo tunnelRepo;
  SplitTunnelController({required this.tunnelRepo});
  static SplitTunnelController get find => Get.find<SplitTunnelController>();

  final List<AppInfo> _apps = [];
  final List<String> _excludedApps = [];
  bool _laoding = false;

  List<AppInfo> get apps => _apps;
  List<String> get excludedApps => _excludedApps;
  bool get loading => _laoding;

  set loading(bool value) {
    _laoding = value;
    update();
  }

  Future<void> getInstalledApps() async {
    if (_apps.isEmpty) {
      loading = true;
    }
    getExcludedApps();
    List<AppInfo> installedApps =
        await InstalledApps.getInstalledApps(true, true);
    for (AppInfo app in installedApps) {
      String packageName = app.packageName;
      if (!_apps.any((e) => e.packageName == packageName)) {
        _apps.add(app);
      }
    }
    loading = false;
  }

  void toggleApp(String packageName) {
    if (_excludedApps.contains(packageName)) {
      _excludedApps.remove(packageName);
    } else {
      _excludedApps.add(packageName);
    }
    saveExcludedApps();
    update();
  }

  Future<void> saveExcludedApps() async {
    await tunnelRepo.saveExcludedApps(_excludedApps);
  }

  void getExcludedApps() {
    _excludedApps.addAll(tunnelRepo.getExcludedApps());
    update();
  }
}
