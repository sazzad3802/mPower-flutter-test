part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState {
  String message;

  LoginSuccessState(this.message);

  @override
  List<Object?> get props => [];
}

class LoginErrorState extends LoginState {
  String message;

  LoginErrorState(this.message);
  @override
  List<Object?> get props => [];
}
