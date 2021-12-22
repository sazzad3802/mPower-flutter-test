import 'package:mpower_flutter_test/data/model/user.dart';

class LoginApiResponse {
  String? token;
  User? user;

  LoginApiResponse({this.token, this.user});

  LoginApiResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
