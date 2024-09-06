import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/snackbar.dart';
import '../../utils/app_constants.dart';
import '../model/response/error.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  final int timeoutInSeconds = 30;

  String? token;

  Map<String, String> _mainHeaders = {
    "Content-Type": "application/json",
    'Accept': 'application/json',
  };

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    updateHeader(
      token ?? '',
      sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ??
          AppConstants.languages[0].languageCode,
    );
  }

  void updateHeader(String token, String? languageCode) {
    token = token;
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      AppConstants.LOCALIZATION_KEY:
          languageCode ?? AppConstants.languages[0].languageCode,
      'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response?> getData(String uri,
      {Map<String, String>? headers,
      bool dismis = true,
      bool uriOnly = false}) async {
    try {
      final String url = uriOnly ? uri : AppConstants.BASE_URL + uri;
      debugPrint('====> API Call: $url\nHeader: $_mainHeaders');
      http.Response response = await http
          .get(Uri.parse(url), headers: headers ?? _mainHeaders)
          .timeout(Duration(seconds: timeoutInSeconds));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (dismis) {
          dismiss();
        }
        return response;
      } else {
        if (kDebugMode) {
          log('Response: ${response.body}');
        }
        return handleError(response.body, response.statusCode);
      }
    } catch (e) {
      dismiss();
      socketException(e, AppConstants.BASE_URL + uri);
      return null;
    }
  }

  handleError(String body, int statusCode) {
    String message = '';
    try {
      ErrorResponse errorResponse = ErrorResponse.fromJson(jsonDecode(body));
      message = errorResponse.errors[0].message;
    } catch (e) {
      message = jsonDecode(body)['message'];
    }
    dismiss();
    showToast(message);
    return null;
  }

  socketException(Object e, String url) {
    if (e is SocketException) {
      showToast('check_internet_connection'.tr);
    } else {
      log("Error Url: $url,\n");
      showToast('something_went_wrong'.tr);
    }
  }
}
