// ignore_for_file: constant_identifier_names

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../data/model/language.dart';
import 'images.dart';

class AppConstants {
  static const String vpnUsername = "";
  static const String vpnPassword = "";
  static const bool certificateVerify =
      true; //Turn it on if you use certificate
  static const bool showSignalStrength = true;
  static const bool cacheServerList = true;
  static bool unlockProServerWithRewardAds = true;
  static bool unlockProServerWithRewardAdsFail = false;

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
  static const String TOPIC = 'notify';
  static const String TOKEN = 'token';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_EMAIL = 'user_email';
  static const String USER_NUMBER = 'user_number';
  static const String LOCALIZATION_KEY = 'X-localization';
  static const String ON_BOARDING_SKIP = 'on_boarding_skip';

  // Language
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.arabic,
        languageName: 'Arabic',
        countryCode: 'SA',
        languageCode: 'ar'),
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
