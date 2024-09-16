import 'package:darkfire_vpn/data/api/api_client.dart';
import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ReviewRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response?> saveReview(Map<String, dynamic> body) async {
    return await apiClient.postData(AppConstants.REVIEW, body);
  }

  Future<bool> setReviewed() async {
    return await sharedPreferences.setBool(AppConstants.REVIEWED, true);
  }

  bool isReviewed() {
    return sharedPreferences.getBool(AppConstants.REVIEWED) ?? false;
  }
}
