import 'package:mpower_flutter_test/config/app_locator.dart';
import 'package:mpower_flutter_test/data/api_response/login_api_response.dart';
import 'package:mpower_flutter_test/data/local/login_model.dart';
import 'package:mpower_flutter_test/domain/service/api_service.dart';

class LoginRepository {
  final ApiService apiService = di<ApiService>();

  Future<LoginApiResponse> login({required LoginModel model}) async {
    LoginApiResponse apiResponse = LoginApiResponse();
    try {
      var response = await apiService.doLogin(model: model);
      apiResponse = LoginApiResponse.fromJson(response.data);
      print(response.toString());
    } catch (e) {
      print(e);
    }
    return apiResponse;
  }
}
