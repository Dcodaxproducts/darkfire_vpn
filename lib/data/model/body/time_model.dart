class TimeModel {
  int remainingTimeInSeconds;
  int durationPassedInSeconds;
  DateTime? lastExtraTimeGiven;

  TimeModel({
    required this.remainingTimeInSeconds,
    this.durationPassedInSeconds = 0,
    this.lastExtraTimeGiven,
  });

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return TimeModel(
      remainingTimeInSeconds: json['remainingTimeInSeconds'] ?? 0,
      durationPassedInSeconds: json['durationPassedInSeconds'] ?? 0,
      lastExtraTimeGiven: json['lastExtraTimeGiven'] != null
          ? DateTime.parse(json['lastExtraTimeGiven'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'remainingTimeInSeconds': remainingTimeInSeconds,
      'durationPassedInSeconds': durationPassedInSeconds,
      'lastExtraTimeGiven': lastExtraTimeGiven?.toIso8601String(),
    };
  }
}
