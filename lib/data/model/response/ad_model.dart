class AdModel {
  int id;
  String type;
  int status;
  String adId;
  String position;

  AdModel({
    required this.id,
    required this.type,
    required this.status,
    required this.adId,
    required this.position,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'],
      type: json['type'],
      status: json['status'],
      adId: json['ad_id'],
      position: json['position'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'status': status,
      'ad_id': adId,
      'position': position,
    };
  }
}
