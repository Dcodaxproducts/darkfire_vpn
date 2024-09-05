// import 'dart:convert';
import 'dart:convert';

import 'package:darkfire_vpn/controllers/localization_controller.dart';
import 'package:darkfire_vpn/controllers/vpn_controller.dart';
// import 'package:darkfire_vpn/data/model/language.dart';
import 'package:darkfire_vpn/data/repository/server_repo.dart';
import 'package:darkfire_vpn/data/repository/vpn_repo.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/ads_controller.dart';
import '../controllers/iap_controller.dart';
import '../controllers/servers_controller.dart';
import '../controllers/splash_controller.dart';
import '../controllers/theme_controller.dart';
import '../data/api/api_client.dart';
import '../data/model/language.dart';
import '../data/repository/language_repo.dart';
import '../data/repository/splash_repo.dart';
import '../utils/app_constants.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(() =>
      SplashRepo(sharedPreferences: sharedPreferences, apiClient: Get.find()));
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => ServerRepo(apiClient: Get.find()));
  Get.lazyPut(() => VpnRepo(sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(
      sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => ServerController(serverRepo: Get.find()));
  Get.lazyPut(() => VpnController(vpnRepo: Get.find()));
  Get.lazyPut(() => AdsController());
  Get.lazyPut(() => IAPController());

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
