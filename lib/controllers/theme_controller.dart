import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_constants.dart';

class ThemeController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  ThemeController({required this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  ThemeMode _themeMode = ThemeMode.light;
  bool _darkTheme = false;
  Color? _lightColor;
  Color? _darkColor;

  ThemeMode get themeMode => _themeMode;
  bool get darkTheme => _darkTheme;
  Color? get darkColor => _darkColor;
  Color? get lightColor => _lightColor;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    _themeMode = _darkTheme ? ThemeMode.dark : ThemeMode.light;
    sharedPreferences.setBool(AppConstants.THEME, _darkTheme);
    update();
  }

  void _loadCurrentTheme() async {
    bool? data = sharedPreferences.getBool(AppConstants.THEME);
    if (data == null) {
      _themeMode = ThemeMode.system;
      // check if system theme is dark
      if (Get.isDarkMode) {
        _darkTheme = true;
      }
    } else if (data) {
      _darkTheme = true;
      _themeMode = ThemeMode.dark;
    } else {
      _darkTheme = false;
      _themeMode = ThemeMode.light;
    }
    update();
  }

  static ThemeController get find => Get.find();
}

bool get isDark => Get.isDarkMode;
