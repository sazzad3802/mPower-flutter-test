import 'package:mpower_flutter_test/config/app_locator.dart';
import 'package:mpower_flutter_test/data/api_response/app_list_api_response.dart';
import 'package:mpower_flutter_test/domain/service/api_service.dart';

class AppRepository {
  final ApiService apiService = di<ApiService>();

  Future<AppListApiResponse> getAllApp() async {
    AppListApiResponse apiResponse = AppListApiResponse();
    try {
      var response = await apiService.getMyApps();
      apiResponse = AppListApiResponse.fromJson(response.data);
      print(response.toString());
    } catch (e) {
      print(e);
    }
    return apiResponse;
  }
}
