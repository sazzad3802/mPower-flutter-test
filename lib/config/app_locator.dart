import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mpower_flutter_test/config/api_client.dart';
import 'package:mpower_flutter_test/config/base_url_config.dart';
import 'package:mpower_flutter_test/config/constant_config.dart';
import 'package:mpower_flutter_test/domain/repository/app_repository.dart';
import 'package:mpower_flutter_test/domain/repository/login_repository.dart';
import 'package:mpower_flutter_test/domain/service/api_service.dart';

final di = GetIt.instance;

Future<void> init() async {
  di.registerSingletonAsync<Dio>(() async {
    return await ApiClient().dio;
  });
  di.registerLazySingleton(() => ApiClient());
  di.registerLazySingleton(() => ConstantConfig());
  di.registerLazySingleton(() => BaseUrlConfig());
  di.registerLazySingleton(() => AppRepository());
  di.registerLazySingleton(() => LoginRepository());
  di.registerLazySingleton(() => ApiService());
}
