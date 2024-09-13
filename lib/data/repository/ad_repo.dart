import 'package:darkfire_vpn/data/api/api_client.dart';
import 'package:darkfire_vpn/utils/app_constants.dart';
import 'package:http/http.dart';

class AdRepo {
  final ApiClient apiClient;
  AdRepo({required this.apiClient});

  Future<Response?> getAdIds() async {
    return await apiClient.getData(AppConstants.GET_ADS);
  }
}
