part of 'app_list_bloc.dart';

abstract class AppListState extends Equatable {
  const AppListState();
}

class AppListInitial extends AppListState {
  @override
  List<Object> get props => [];
}

class AppListLoadingState extends AppListState {
  @override
  List<Object?> get props => [];
}

class AppListSuccessState extends AppListState {
  List<MyApp> myApps;
  List<List<MyApp>> appTypeNameList;

  AppListSuccessState(this.myApps, this.appTypeNameList);

  @override
  List<Object?> get props => [myApps, appTypeNameList];
}

class AppListErrorState extends AppListState {
  String message;

  AppListErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
