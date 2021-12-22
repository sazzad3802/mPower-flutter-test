part of 'app_list_bloc.dart';

abstract class AppListEvent extends Equatable {
  const AppListEvent();
}

class AppListLoading extends AppListEvent {
  @override
  List<Object?> get props => [];
}

class FetchAppList extends AppListEvent {
  @override
  List<Object?> get props => [];
}

class ReloadAllApps extends AppListEvent {
  @override
  List<Object?> get props => [];
}
