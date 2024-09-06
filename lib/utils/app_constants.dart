// ignore_for_file: constant_identifier_names

import 'package:darkfire_vpn/data/model/body/subscription_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../data/model/language.dart';

class AppConstants {
  static const String vpnUsername = "";
  static const String vpnPassword = "";
  static const bool certificateVerify = true;
  static const bool cacheServerList = true;

  //
  static const int freeUserConnectionLimitInSeconds = 60 * 60;
  static const int extraTimeInSeconds = 30 * 60;
  static const int extraTimeReloadMinutes = 60;

  ///Customize your adRequest here
  static AdRequest get adRequest => const AdRequest();

// iOS setup
  static const String providerBundleIdentifier =
      "app.nerd.vpn.VPNExtension"; //Before it was VpnExtensionIdentifier
  static const String groupIdentifier = "group.app.nerd.vpn";
  static const String iosAppID = "1234567890";
  static const String localizationDescription = "Nerd VPN - Fast & Secure VPN";
  //
  static const String APP_NAME = 'DarkFire VPN';

  static const String BASE_URL = 'https://dvpn.dcodax.net/api/';

  // endpoints
  static const String APP_SETTING = '/appsetting';

  static const String NOTIFICATION_URI = '/notification-list';

  // Shared Key
  static const String THEME = 'theme';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String EXTRA_TIME = 'extra_time';
  static const String LOCALIZATION_KEY = 'X-localization';
  static const String ON_BOARDING_SKIP = 'on_boarding_skip';

  // Language
  static List<LanguageModel> languages = [
    LanguageModel(
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
    LanguageModel(
      languageName: 'Arabic',
      countryCode: 'SA',
      languageCode: 'ar',
    ),
    LanguageModel(
      languageName: 'French',
      countryCode: 'FR',
      languageCode: 'fr',
    ),
    LanguageModel(
      languageName: 'Indonesian',
      countryCode: 'ID',
      languageCode: 'id',
    ),
    LanguageModel(
      languageName: 'Portuguese',
      countryCode: 'PT',
      languageCode: 'pt',
    ),
    LanguageModel(
      languageName: 'Spanish',
      countryCode: 'ES',
      languageCode: 'es',
    ),
    LanguageModel(
      languageName: 'Turkish',
      countryCode: 'TR',
      languageCode: 'tr',
    ),
    LanguageModel(
      languageName: 'Hindi',
      countryCode: 'IN',
      languageCode: 'hi',
    ),
    LanguageModel(
      languageName: 'Russian',
      countryCode: 'RU',
      languageCode: 'ru',
    ),
    LanguageModel(
      languageName: 'German',
      countryCode: 'DE',
      languageCode: 'de',
    ),
    LanguageModel(
      languageName: 'Chinese',
      countryCode: 'CN',
      languageCode: 'zh',
    ),
    LanguageModel(
      languageName: 'Japanese',
      countryCode: 'JP',
      languageCode: 'ja',
    ),
    LanguageModel(
      languageName: 'Korean',
      countryCode: 'KR',
      languageCode: 'ko',
    ),
    LanguageModel(
      languageName: 'Italian',
      countryCode: 'IT',
      languageCode: 'it',
    ),
    LanguageModel(
      languageName: 'Vietnamese',
      countryCode: 'VN',
      languageCode: 'vi',
    ),
    LanguageModel(
      languageName: 'Urdu',
      countryCode: 'PK',
      languageCode: 'ur',
    ),
    LanguageModel(
      languageName: 'Dutch',
      countryCode: 'NL',
      languageCode: 'nl',
    ),
    LanguageModel(
      languageName: 'Tamil',
      countryCode: 'IN',
      languageCode: 'ta',
    ),
    LanguageModel(
      languageName: 'Telugu',
      countryCode: 'IN',
      languageCode: 'te',
    ),
    // language codes from above list,
  ];

  static List<SubscriptionModel> subscriptionList = [
    SubscriptionModel(
      name: "One Week Subscription",
      duration: const Duration(days: 7),
      gracePeriod: const Duration(days: 1),
      featured: false,
      price: 'PKR 100',
    ),
    SubscriptionModel(
      name: "One Month Subscription",
      duration: const Duration(days: 30),
      gracePeriod: const Duration(days: 7),
      featured: true,
      price: 'PKR 300',
    ),
    SubscriptionModel(
      name: "One Year Subscription",
      duration: const Duration(days: 365),
      gracePeriod: const Duration(days: 7),
      featured: false,
      price: 'PKR 1000',
    ),
  ];

  static const Map<String, Map<String, dynamic>> subscriptionIdentifier = {
    "one_week_subs": {
      "name": "One Week Subscription", //This is your subscription name
      "duration": Duration(days: 7), //This is your subscription duration
      "grace_period":
          Duration(days: 1), //This is your subscription grace period
      "featured": false, //This is your subscription if it featured or not
    },
    "one_month_subs": {
      "name": "One Month Subscription",
      "duration": Duration(days: 30),
      "grace_period": Duration(days: 7),
      "featured": true,
    },
    "one_year_subs": {
      "name": "One Year Subscription",
      "duration": Duration(days: 365),
      "grace_period": Duration(days: 7),
      "featured": false,
    },
  };
}
