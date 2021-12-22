part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginLoading extends LoginEvent {
  String name;
  String password;

  LoginLoading(this.name, this.password);

  @override
  List<Object?> get props => [];
}

class DoLogin extends LoginEvent {
  LoginModel model;

  DoLogin({required this.model});

  @override
  List<Object?> get props => [model];
}
