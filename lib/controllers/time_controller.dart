import 'package:darkfire_vpn/controllers/vpn_controller.dart';
import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:workmanager/workmanager.dart';
import '../common/navigation.dart';
import '../data/model/body/time_model.dart';
import '../data/repository/time_repo.dart';
import '../view/screens/report/report.dart';

class TimeController extends GetxController implements GetxService {
  final TimeRepo timeRepo;
  TimeController({required this.timeRepo});

  static TimeController get find => Get.find<TimeController>();

  DateTime? _lastExtraTimeGiven;
  int _remainingTimeInSeconds = AppConstants.freeUserConnectionLimitInSeconds;

  DateTime? get lastExtraTimeGiven => _lastExtraTimeGiven;
  int get remainingTimeInSeconds => _remainingTimeInSeconds;

  Future<void> addExtraTime({bool hour = false}) async {
    // add extra time to remaining time
    _remainingTimeInSeconds +=
        (AppConstants.extraTimeInSeconds * (hour ? 2 : 1));
    _lastExtraTimeGiven = DateTime.now();

    TimeModel data = TimeModel(
      lastExtraTimeGiven: _lastExtraTimeGiven,
      remainingTimeInSeconds: _remainingTimeInSeconds,
    );

    await timeRepo.saveExtraTime(data.toJson());
    update();
  }

  bool canAvailExtraTime() {
    if (_lastExtraTimeGiven == null) return true;
    int diff = DateTime.now().difference(_lastExtraTimeGiven!).inMinutes;
    if (diff < AppConstants.extraTimeReloadMinutes) {
      return false;
    }
    return true;
  }

  void loadExtraTime() {
    TimeModel data = TimeModel.fromJson(timeRepo.getExtraTime());
    _lastExtraTimeGiven = data.lastExtraTimeGiven;
    _remainingTimeInSeconds = data.remainingTimeInSeconds;
    update();
  }

  int updateRemainingTime(VpnStatus? vpnStatus) {
    if (vpnStatus != null) {
      _remainingTimeInSeconds--;
      if (_remainingTimeInSeconds <= 5) {
        cancelTask();
        VpnController.find.disconnect((vpnStatus, vpnConfig) {
          launchScreen(
            ReportScreen(vpnStatus: vpnStatus, vpnConfig: vpnConfig),
          );
        });
      }
      update();
      TimeModel data = TimeModel(
        lastExtraTimeGiven: _lastExtraTimeGiven,
        remainingTimeInSeconds: _remainingTimeInSeconds,
      );
      timeRepo.saveExtraTime(data.toJson());
      if (_remainingTimeInSeconds > 5) {
        scheduleVpnDisconnection();
      }
    }
    return _remainingTimeInSeconds;
  }

  void scheduleVpnDisconnection() async {
    await cancelTask();
    // Schedule the VPN disconnection when remaining time reaches zero
    Workmanager().registerOneOffTask(
      'vpn_disconnection_task',
      'vpn_disconnection_task',
      initialDelay: Duration(seconds: _remainingTimeInSeconds),
    );
  }

  Future<void> cancelTask() async {
    await Workmanager().cancelByUniqueName('vpn_disconnection_task');
  }
}