import 'package:darkfire_vpn/utils/app_constants.dart';

class TimeModel {
  int remainingTimeInSeconds;
  DateTime? lastExtraTimeGiven;

  TimeModel({
    required this.remainingTimeInSeconds,
    this.lastExtraTimeGiven,
  });

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return TimeModel(
      remainingTimeInSeconds: json['remainingTimeInSeconds'] ??
          AppConstants.freeUserConnectionLimitInSeconds,
      lastExtraTimeGiven: json['lastExtraTimeGiven'] != null
          ? DateTime.parse(json['lastExtraTimeGiven'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'remainingTimeInSeconds': remainingTimeInSeconds,
      'lastExtraTimeGiven': lastExtraTimeGiven?.toIso8601String(),
    };
  }
}
