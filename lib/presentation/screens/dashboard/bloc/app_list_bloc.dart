import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mpower_flutter_test/config/app_locator.dart';
import 'package:mpower_flutter_test/data/api_response/app_list_api_response.dart';
import 'package:mpower_flutter_test/data/model/my_app.dart';
import 'package:mpower_flutter_test/domain/repository/app_repository.dart';

part 'app_list_event.dart';
part 'app_list_state.dart';

class AppListBloc extends Bloc<AppListEvent, AppListState> {
  final AppRepository _appRepository = di<AppRepository>();
  AppListBloc() : super(AppListLoadingState());

  @override
  Stream<AppListState> mapEventToState(AppListEvent event) async* {
    if (event is FetchAppList || event is ReloadAllApps) {
      AppListApiResponse _apiResponse = await _appRepository.getAllApp();
      if (_apiResponse.status == 200) {
        List<String> types = _apiResponse.myapps!
            .map((e) => e.applicationType!)
            .toSet()
            .toList();
        List<List<MyApp>> appList = types.map((type) {
          return _apiResponse.myapps!.where((element) {
            return element.applicationType!.compareTo(type) == 0;
          }).toList();
        }).toList();
        yield AppListSuccessState(_apiResponse.myapps!, appList);
      } else {
        yield AppListErrorState('Something went wrong! please try again');
      }
    } else if (event is AppListLoading) {
      yield AppListLoadingState();
    }
  }
}
