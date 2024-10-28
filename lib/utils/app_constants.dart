// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:io';
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
  static AdRequest get adRequest => const AdRequest(httpTimeoutMillis: 6000);

  // package name
  static const String androidPackageName =
      "speed.secure.vpn.proxy.master.vynox";
  static const String iOSPackageName = "speed.secure.vpn.proxy.master.vynox";

// iOS setup
  static const String providerBundleIdentifier =
      "$iOSPackageName.VPNExtension"; //Before it was VpnExtensionIdentifier
  static const String groupIdentifier = "group.$iOSPackageName";
  static const String iosAppID = "1234567890";
  static const String localizationDescription = "Vynox VPN - Proxy VPN Master";

  /* App name and version */
  static const String APP_NAME = 'Vynox VPN';

  /* Non Customizable */

  static const String BASE_URL = 'https://vpn.feastflow.co/api/';
  static const String API_URL = 'https://vpn.feastflow.co';

  // endpoints
  static const String GET_ADS = 'ad';
  static const String REVIEW = 'review/store';

  // Shared Key
  static const String THEME = 'theme';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String EXTRA_TIME = 'extra_time';
  static const String LOCALIZATION_KEY = 'X-localization';
  static const String ON_BOARDING_SKIP = 'on_boarding_skip';
  static String VPN_DISCONNECT_TASK = Platform.isIOS
      ? "speed.secure.vpn.proxy.master.vynox.vpn_disconnection_task"
      : 'vpn_disconnection_task';
  static const String REVIEWED = 'reviewed';

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

  /* Subscription Url's */
  static const String cancelSubscriptionUrl =
      'https://play.google.com/store/account/subscriptions?pli=1';
  static const String privacyPolicyUrl =
      'https://payments.google.com/payments/apis-secure/u/0/get_legal_document?ldo=0&ldt=privacynotice&ldl=en_GB';
  static const String termsAndConditionsUrl =
      'https://payments.google.com/payments/apis-secure/u/0/get_legal_document?ldl=en_GB&ldo=0&ldt=buyertos';

  /* Privacy and terms Url's */
  static const String appPrivacyPolicyUrl = '$API_URL/privacy-policy';
  static const String appTermsAndConditionsUrl = '$API_URL/terms-condition';

  /* Admob Ads */
  static const String appOpenAdID = "ca-app-pub-7125457258157666/8482870188";
  static const String interstitialAdID =
      "ca-app-pub-7125457258157666/8543975164";
  static const String rewardAdId = "ca-app-pub-7125457258157666/5059464648";
  static const String bannerAdID = "ca-app-pub-3940256099942544/6300978111";
}
