// ignore_for_file: constant_identifier_names

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

// iOS setup
  static const String providerBundleIdentifier =
      "app.darkfire.vpn.VPNExtension"; //Before it was VpnExtensionIdentifier
  static const String groupIdentifier = "group.app.darkfire.vpn";
  static const String iosAppID = "1234567890";
  static const String localizationDescription = "Speed VPN - Proxy VPN Master";

  /* App name and version */
  static const String APP_NAME = 'Speed VPN';
  static const String APP_VERSION = '1.0';

  /* Non Customizable */

  static const String BASE_URL = 'https://dvpn.dcodax.net/api/';

  // endpoints
  static const String APP_SETTING = '/appsetting';

  // Shared Key
  static const String THEME = 'theme';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String EXTRA_TIME = 'extra_time';
  static const String LOCALIZATION_KEY = 'X-localization';
  static const String ON_BOARDING_SKIP = 'on_boarding_skip';
  static const String VPN_DISCONNECT_TASK = 'vpn_disconnection_task';

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
}
