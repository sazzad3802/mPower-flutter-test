import 'dart:io';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:mpower_flutter_test/config/base_url_config.dart';

class ApiClient {
  Future<Dio> get dio async => Dio(
        BaseOptions(
          baseUrl: BaseUrlConfig().BASE_URL,
        ),
      );

  Future<String> getCSRFToken(CookieJar cookieJar) async {
    List<Cookie> cookies =
        await cookieJar.loadForRequest(Uri.parse(BaseUrlConfig().BASE_URL));
    return cookies.isNotEmpty
        ? cookies.firstWhere((c) => c.name == 'csrftoken').value
        : '';
  }
}
