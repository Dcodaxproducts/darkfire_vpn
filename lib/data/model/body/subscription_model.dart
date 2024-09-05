class SubscriptionModel {
  final String name;
  final Duration duration;
  final Duration gracePeriod;
  final bool featured;
  final String price;

  SubscriptionModel({
    required this.name,
    required this.duration,
    required this.gracePeriod,
    required this.featured,
    required this.price,
  });
}
