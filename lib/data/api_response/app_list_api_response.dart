import 'package:mpower_flutter_test/data/model/my_app.dart';

class AppListApiResponse {
  String? message;
  int? status;
  List<MyApp>? myapps;

  AppListApiResponse({this.message, this.status, this.myapps});

  AppListApiResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      myapps = <MyApp>[];
      json['data'].forEach((v) {
        myapps!.add(MyApp.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (myapps != null) {
      data['data'] = myapps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
