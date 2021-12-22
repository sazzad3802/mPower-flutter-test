import 'package:shared_preferences/shared_preferences.dart';

class Constant {
  /*Error Messages*/
  static const String nameEmptyMessage = "name cannot be empty!";
  static const String passEmptyMessage = "password cannot be empty!";

  static getApiToken() async {
    String? token;
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      token = pref.getString('token')!;
    } catch (e) {
      print(e.toString());
    }
    return token;
  }
}
