import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpower_flutter_test/config/api_client.dart';
import 'package:mpower_flutter_test/config/app_locator.dart';
import 'package:mpower_flutter_test/config/base_url_config.dart';
import 'package:mpower_flutter_test/config/constant_config.dart';
import 'package:mpower_flutter_test/data/local/login_model.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:mpower_flutter_test/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Dio dio = di<Dio>();
  final ApiClient _apiClient = di<ApiClient>();
  ConstantConfig constantConfig = di<ConstantConfig>();
  BaseUrlConfig baseConfig = di<BaseUrlConfig>();

  final cookieJar = CookieJar();

  Future doLogin({required LoginModel model}) async {
    dio.interceptors.add(CookieManager(cookieJar));

    return dio.post(
      '${baseConfig.BASE_URL}/api/login/',
      data: {
        "username": model.userName,
        "password": model.password,
      },
    );
  }

  Future getMyApps() async {
    String token = Constant.getApiToken();
    /*try {
      String _csrfToken = await _apiClient.getCSRFToken(cookieJar);
      print("CSRF Token : $_csrfToken");
    } catch (e) {
      print(e.toString());
    }*/
    if (token.isNotEmpty) {
      return dio.post(
        '${baseConfig.BASE_URL}/api/mobile/application_list/',
        options: Options(headers: {
          "Authorization": "JWT " + token,
          "Connection": "keep-alive",
          "Accept-Encoding": "gzip, deflate, br",
          // 'X-CSRFToken': _csrfToken,
        }),
      );
    } else {
      Fluttertoast.showToast(msg: 'Missing Api token');
      return;
    }
  }
}
