import 'dart:developer';

import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import '../data/model/body/time_model.dart';
import '../data/repository/time_repo.dart';

class TimeController extends GetxController implements GetxService {
  final TimeRepo timeRepo;
  TimeController({required this.timeRepo});

  static TimeController get find => Get.find<TimeController>();

  DateTime? _lastExtraTimeGiven;
  int _extraTimeGivenInSeconds = 0;
  int _remainingTimeInSeconds = AppConstants.freeUserConnectionLimitInSeconds;
  int _durationPassedInSeconds = 0;

  DateTime? get lastExtraTimeGiven => _lastExtraTimeGiven;
  int get extraTimeGivenInMinutes => _extraTimeGivenInSeconds;
  int get remainingTimeInSeconds => _remainingTimeInSeconds;
  int get durationPassedInSeconds => _durationPassedInSeconds;

  Future<void> addExtraTime() async {
    // get difference of time between now and lastExtraTimeGiven in minutes
    if (!canAvailExtraTime()) {
      return;
    }
    // add extra time to remaining time
    _extraTimeGivenInSeconds += AppConstants.extraTimeInMinutes;
    _lastExtraTimeGiven = DateTime.now();

    TimeModel data = TimeModel(
        lastExtraTimeGiven: _lastExtraTimeGiven,
        remainingTimeInSeconds: _remainingTimeInSeconds,
        durationPassedInSeconds: _durationPassedInSeconds);

    await timeRepo.saveExtraTime(data.toJson());
    update();
  }

  bool canAvailExtraTime() {
    // if (_lastExtraTimeGiven == null) return true;
    // int diff = DateTime.now().difference(_lastExtraTimeGiven!).inMinutes;
    // if (diff < AppConstants.extraTimeReloadMinutes) {
    //   return false;
    // }
    return true;
  }

  void loadExtraTime() {
    TimeModel data = TimeModel.fromJson(timeRepo.getExtraTime());
    _lastExtraTimeGiven = data.lastExtraTimeGiven;
    _remainingTimeInSeconds = data.remainingTimeInSeconds;
    _durationPassedInSeconds = data.durationPassedInSeconds;
    update();
  }

  void resetExtraTime() {
    _lastExtraTimeGiven = null;
    _remainingTimeInSeconds = AppConstants.freeUserConnectionLimitInSeconds;
    TimeModel data = TimeModel(
      lastExtraTimeGiven: _lastExtraTimeGiven,
      remainingTimeInSeconds: _remainingTimeInSeconds,
    );
    timeRepo.saveExtraTime(data.toJson());
    update();
  }

  int updateRemainingTime(VpnStatus? vpnStatus) {
    if (vpnStatus != null) {
      // // get duration in seconds from (00:00:00) format
      // String duration = vpnStatus.duration ?? '00:00:00';
      // List<String> time = duration.split(':');
      // int hours = int.parse(time[0]);
      // int minutes = int.parse(time[1]);
      // int seconds = int.parse(time[2]);
      // // Calculate total passed time in seconds
      // int passedTimeInSeconds = (hours * 3600) + (minutes * 60) + seconds;
      // _durationPassedInSeconds = passedTimeInSeconds;

      // // Calculate remaining time based on original time minus passed time
      // int originalTimeInSeconds = AppConstants.freeUserConnectionLimitInSeconds;
      // int updatedRemainingTime = originalTimeInSeconds - passedTimeInSeconds;

      // // Include any extra time that was given
      // _remainingTimeInSeconds = updatedRemainingTime + calculateExtraTime();

      // // Ensure remaining time cannot go below 0
      // _remainingTimeInSeconds =
      //     updatedRemainingTime > 0 ? updatedRemainingTime : 0;
      _remainingTimeInSeconds--;

      update();
      TimeModel data = TimeModel(
        lastExtraTimeGiven: _lastExtraTimeGiven,
        remainingTimeInSeconds: _remainingTimeInSeconds,
        durationPassedInSeconds: _durationPassedInSeconds,
      );
      timeRepo.saveExtraTime(data.toJson());
    }
    return _remainingTimeInSeconds;
  }

  int calculateExtraTime() {
    // Calculate how much extra time the user has received
    int originalTimeInSeconds = AppConstants.freeUserConnectionLimitInSeconds;
    int extraTime = _remainingTimeInSeconds -
        (originalTimeInSeconds - _durationPassedInSeconds);
    return extraTime > 0 ? extraTime : 0;
  }
}
