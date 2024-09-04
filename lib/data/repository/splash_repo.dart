import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class SplashRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({required this.sharedPreferences, required this.apiClient});

  Future<Response?> getConfig() async =>
      await apiClient.getData("AppConstants.CONFIG_URI");

  Future<bool> initSharedData() async {
    if (!sharedPreferences.containsKey(AppConstants.THEME)) {
      sharedPreferences.setBool(AppConstants.THEME, false);
    }
    if (!sharedPreferences.containsKey(AppConstants.COUNTRY_CODE)) {
      sharedPreferences.setString(
          AppConstants.COUNTRY_CODE, AppConstants.languages[0].countryCode);
    }
    if (!sharedPreferences.containsKey(AppConstants.LANGUAGE_CODE)) {
      sharedPreferences.setString(
          AppConstants.LANGUAGE_CODE, AppConstants.languages[0].languageCode);
    }
    if (!sharedPreferences.containsKey(AppConstants.ON_BOARDING_SKIP)) {
      return sharedPreferences.setBool(AppConstants.ON_BOARDING_SKIP, true);
    }
    return Future.value(true);
  }

  Future<bool> removeSharedData() {
    return sharedPreferences.clear();
  }

  Future<bool> saveFirstTime() async =>
      await sharedPreferences.setBool(AppConstants.ON_BOARDING_SKIP, false);

  bool getFirstTime() =>
      sharedPreferences.getBool(AppConstants.ON_BOARDING_SKIP) ?? false;
}
