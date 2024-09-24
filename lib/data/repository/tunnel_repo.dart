import 'package:shared_preferences/shared_preferences.dart';

class TunnelRepo {
  final SharedPreferences sharedPreferences;
  TunnelRepo({required this.sharedPreferences});

  Future<bool> saveExcludedApps(List<String> selectedApps) async {
    return await sharedPreferences.setStringList('excludedApps', selectedApps);
  }

  List<String> getExcludedApps() {
    return sharedPreferences.getStringList('excludedApps') ?? [];
  }
}
