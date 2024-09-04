class ConfigModel {
  String? restaurantName;
  String? restaurantLogo;
  String? restaurantAddress;
  String? restaurantPhone;
  String? restaurantEmail;
  BaseUrls? baseUrls;
  String? currencySymbol;
  double? deliveryCharge;
  String? cashOnDelivery;
  String? digitalPayment;
  String? termsAndConditions;
  String? privacyPolicy;
  String? aboutUs;
  bool? emailVerification;
  bool? phoneVerification;
  String? currencySymbolPosition;
  bool? maintenanceMode;
  String? countryCode;
  bool? selfPickup;
  bool? homeDelivery;
  RestaurantLocationCoverage? restaurantLocationCoverage;
  double? minimumOrderValue;
  List<Branches>? branches;
  DeliveryManagement? deliveryManagement;
  PlayStoreConfig? playStoreConfig;
  AppStoreConfig? appStoreConfig;
  List<SocialMediaLink>? socialMediaLink;
  String? softwareVersion;
  String? footerCopyright;
  String? timeZone;
  int? decimalPointSettings;
  List<RestaurantScheduleTime>? restaurantScheduleTime;
  int? scheduleOrderSlotDuration;
  String? timeFormat;
  bool? walletPayment, loyaltyPointStatus;
  double? taxPercentage;
  bool taxEnabled;
  num? loyaltyPointExchangeRate, loyaltyPointMinimumPoint;
  bool? loyaltyStatus;
  bool? theme1;
  SocialLogin? socialLogin;

  ConfigModel({
    this.restaurantName,
    this.restaurantLogo,
    this.restaurantAddress,
    this.restaurantPhone,
    this.restaurantEmail,
    this.baseUrls,
    this.currencySymbol,
    this.deliveryCharge,
    this.cashOnDelivery,
    this.digitalPayment,
    this.termsAndConditions,
    this.privacyPolicy,
    this.aboutUs,
    this.emailVerification,
    this.phoneVerification,
    this.currencySymbolPosition,
    this.maintenanceMode,
    this.countryCode,
    this.restaurantLocationCoverage,
    this.minimumOrderValue,
    this.branches,
    this.selfPickup,
    this.homeDelivery,
    this.deliveryManagement,
    this.playStoreConfig,
    this.appStoreConfig,
    this.socialMediaLink,
    this.softwareVersion,
    this.footerCopyright,
    this.timeZone,
    this.decimalPointSettings,
    this.restaurantScheduleTime,
    this.scheduleOrderSlotDuration,
    this.timeFormat,
    this.walletPayment,
    this.taxPercentage,
    this.taxEnabled = false,
    this.loyaltyPointStatus,
    this.loyaltyPointExchangeRate,
    this.loyaltyPointMinimumPoint,
    this.loyaltyStatus,
    this.theme1,
    this.socialLogin,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
        restaurantName: json["restaurant_name"],
        restaurantLogo: json["restaurant_logo"],
        restaurantAddress: json["restaurant_address"],
        restaurantPhone: json["restaurant_phone"],
        restaurantEmail: json["restaurant_email"],
        baseUrls: json["base_urls"] != null
            ? BaseUrls.fromJson(json["base_urls"])
            : null,
        currencySymbol: json["currency_symbol"],
        deliveryCharge: json["delivery_charge"].toDouble(),
        cashOnDelivery: json["cash_on_delivery"],
        digitalPayment: json["digital_payment"],
        termsAndConditions: json["terms_and_conditions"],
        privacyPolicy: json["privacy_policy"],
        aboutUs: json["about_us"],
        emailVerification: json["email_verification"],
        phoneVerification: json["phone_verification"],
        currencySymbolPosition: json["currency_symbol_position"],
        maintenanceMode: json["maintenance_mode"],
        countryCode: json["country"],
        selfPickup: json["self_pickup"],
        homeDelivery: json["delivery"],
        restaurantLocationCoverage: json["restaurant_location_coverage"] == null
            ? null
            : RestaurantLocationCoverage.fromJson(
                json["restaurant_location_coverage"]),
        minimumOrderValue: json["minimum_order_value"] == null
            ? 0
            : json["minimum_order_value"].toDouble(),
        branches: json["branches"] == null
            ? []
            : List<Branches>.from(
                json["branches"].map((x) => Branches.fromJson(x))),
        deliveryManagement: json["delivery_management"] == null
            ? null
            : DeliveryManagement.fromJson(json["delivery_management"]),
        playStoreConfig: json["play_store_config"] == null
            ? null
            : PlayStoreConfig.fromJson(json["play_store_config"]),
        appStoreConfig: json["app_store_config"] == null
            ? null
            : AppStoreConfig.fromJson(json["app_store_config"]),
        socialMediaLink: json["social_media_link"] == null
            ? []
            : List<SocialMediaLink>.from(json["social_media_link"]
                .map((x) => SocialMediaLink.fromJson(x))),
        softwareVersion: json["software_version"] ?? '',
        footerCopyright: json["footer_text"] ?? '',
        timeZone: json["time_zone"] ?? '',
        decimalPointSettings: json["decimal_point_settings"] ?? 1,
        restaurantScheduleTime: json["restaurant_schedule_time"] == null
            ? []
            : List<RestaurantScheduleTime>.from(json["restaurant_schedule_time"]
                .map((x) => RestaurantScheduleTime.fromJson(x))),
        scheduleOrderSlotDuration: json["schedule_order_slot_duration"] == null
            ? 30
            : int.parse(json["schedule_order_slot_duration"].toString()),
        timeFormat: json["time_format"],
        walletPayment: json["wallet_status"] == 0 ? false : true,
        loyaltyPointStatus: json["loyalty_point_status"] == 0 ? false : true,
        taxPercentage: json["overall_tax"] == null
            ? 0
            : double.parse(json["overall_tax"].toString()),
        taxEnabled: (json["tax_status"] == 0 || json["tax_status"] == null)
            ? false
            : true,
        loyaltyPointExchangeRate: json["loyalty_point_exchange_rate"] == null ||
                json["loyalty_point_exchange_rate"] == ''
            ? 0
            : num.parse(json["loyalty_point_exchange_rate"].toString()),
        loyaltyPointMinimumPoint: json["loyalty_point_minimum_point"] == null ||
                json["loyalty_point_minimum_point"] == ''
            ? 0
            : num.parse(json["loyalty_point_minimum_point"].toString()),
        loyaltyStatus: json["loyalty_point_status"] == null ||
                json["loyalty_point_status"] == 0
            ? false
            : true,
        theme1: json["theme"] == null || json["theme"] == 1 ? false : true,
        socialLogin: json["social_login"] == null
            ? null
            : SocialLogin.fromJson(json["social_login"]),
      );
}

class BaseUrls {
  String? productImageUrl;
  String? customerImageUrl;
  String? bannerImageUrl;
  String? categoryImageUrl;
  String? categoryBannerImageUrl;
  String? reviewImageUrl;
  String? notificationImageUrl;
  String? restaurantImageUrl;
  String? deliveryManImageUrl;
  String? chatImageUrl;
  String? orderConfirmationImage;

  BaseUrls({
    this.productImageUrl,
    this.customerImageUrl,
    this.bannerImageUrl,
    this.categoryImageUrl,
    this.categoryBannerImageUrl,
    this.reviewImageUrl,
    this.notificationImageUrl,
    this.restaurantImageUrl,
    this.deliveryManImageUrl,
    this.chatImageUrl,
    this.orderConfirmationImage,
  });

  factory BaseUrls.fromJson(Map<String, dynamic> json) => BaseUrls(
        productImageUrl: json["product_image_url"] ?? '',
        customerImageUrl: json["customer_image_url"] ?? '',
        bannerImageUrl: json["banner_image_url"] ?? '',
        categoryImageUrl: json["category_image_url"] ?? '',
        categoryBannerImageUrl: json["category_banner_image_url"] ?? '',
        reviewImageUrl: json["review_image_url"] ?? '',
        notificationImageUrl: json["notification_image_url"] ?? '',
        restaurantImageUrl: json["restaurant_image_url"] ?? '',
        deliveryManImageUrl: json["delivery_man_image_url"] ?? '',
        chatImageUrl: json["chat_image_url"] ?? '',
        orderConfirmationImage: json["order_confirmation_image_path"] ?? '',
      );
}

class RestaurantLocationCoverage {
  String? longitude;
  String? latitude;
  double? coverage;

  RestaurantLocationCoverage({
    this.longitude,
    this.latitude,
    this.coverage,
  });

  factory RestaurantLocationCoverage.fromJson(Map<String, dynamic> json) =>
      RestaurantLocationCoverage(
        longitude: json["longitude"],
        latitude: json["latitude"],
        coverage: json["coverage"] == null ? 0 : json["coverage"].toDouble(),
      );
}

class Branches {
  int? id;
  String? name;
  String? email;
  String? longitude;
  String? latitude;
  String? address;
  double? coverage;
  double? distance;

  Branches({
    this.id,
    this.name,
    this.email,
    this.longitude,
    this.latitude,
    this.address,
    this.coverage,
    this.distance,
  });

  factory Branches.fromJson(Map<String, dynamic> json) => Branches(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        address: json["address"],
        coverage: json["coverage"] == null ? 0 : json["coverage"].toDouble(),
      );
}

class DeliveryManagement {
  int? status;
  double? minShippingCharge;
  double? shippingPerKm;

  DeliveryManagement({
    this.status,
    this.minShippingCharge,
    this.shippingPerKm,
  });

  factory DeliveryManagement.fromJson(Map<String, dynamic> json) =>
      DeliveryManagement(
        status: json["status"],
        minShippingCharge: json["min_shipping_charge"] == null
            ? 0
            : json["min_shipping_charge"].toDouble(),
        shippingPerKm: json["shipping_per_km"] == null
            ? 0
            : json["shipping_per_km"].toDouble(),
      );
}

class PlayStoreConfig {
  bool? status;
  String? link;
  double? minVersion;

  PlayStoreConfig({
    this.status,
    this.link,
    this.minVersion,
  });

  factory PlayStoreConfig.fromJson(Map<String, dynamic> json) =>
      PlayStoreConfig(
        status: json["status"],
        link: json["link"],
        minVersion: json["min_version"] == null
            ? 1
            : double.parse(json["min_version"].toString()),
      );
}

class AppStoreConfig {
  bool? status;
  String? link;
  double? minVersion;

  AppStoreConfig({
    this.status,
    this.link,
    this.minVersion,
  });

  factory AppStoreConfig.fromJson(Map<String, dynamic> json) => AppStoreConfig(
        status: json["status"],
        link: json["link"],
        minVersion: json["min_version"] == null
            ? 1
            : double.parse(json["min_version"].toString()),
      );
}

class SocialMediaLink {
  int? id;
  String? name;
  String? link;
  int? status;
  String? updatedAt;

  SocialMediaLink({
    this.id,
    this.name,
    this.link,
    this.status,
    this.updatedAt,
  });

  factory SocialMediaLink.fromJson(Map<String, dynamic> json) =>
      SocialMediaLink(
        id: json["id"],
        name: json["name"],
        link: json["link"],
        status: json["status"],
        updatedAt: json["updated_at"],
      );
}

class RestaurantScheduleTime {
  String day;
  String openingTime;
  String closingTime;

  RestaurantScheduleTime({
    required this.day,
    required this.openingTime,
    required this.closingTime,
  });

  factory RestaurantScheduleTime.fromJson(Map<String, dynamic> json) =>
      RestaurantScheduleTime(
        day: json["day"].toString(),
        openingTime: json["opening_time"].toString(),
        closingTime: json["closing_time"].toString(),
      );
}

class SocialLogin {
  bool facebook;
  bool google;

  SocialLogin({
    required this.facebook,
    required this.google,
  });

  factory SocialLogin.fromJson(Map<String, dynamic> json) => SocialLogin(
        facebook: json["facebook"] == 1 ? true : false,
        google: json["google"] == 1 ? true : false,
      );
}
