import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpower_flutter_test/config/app_locator.dart';
import 'package:mpower_flutter_test/data/api_response/login_api_response.dart';
import 'package:mpower_flutter_test/data/local/login_model.dart';
import 'package:mpower_flutter_test/domain/repository/login_repository.dart';
import 'package:mpower_flutter_test/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository = di<LoginRepository>();

  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is DoLogin) {
      LoginApiResponse _userAuth =
          await _loginRepository.login(model: event.model);
      if (_userAuth.token != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user', jsonEncode(_userAuth.user!.toJson()));
        prefs.setString('token', _userAuth.token!);
        yield LoginSuccessState('Login successful');
      } else {
        yield LoginErrorState('Something went wrong! please try again');
      }
    } else if (event is LoginLoading) {
      if (validate(event)) {
        yield LoginLoadingState();
      }
    }
  }

  bool validate(LoginLoading event) {
    bool isValid = true;
    if (event.name.isEmpty) {
      Fluttertoast.showToast(msg: Constant.nameEmptyMessage);
      return false;
    }
    if (event.password.isEmpty) {
      Fluttertoast.showToast(msg: Constant.passEmptyMessage);
      return false;
    }
    return isValid;
  }
}
