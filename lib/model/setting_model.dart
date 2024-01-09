// ignore_for_file: void_checks

class SettingModel {
  bool? status;
  void message;
  Data? data;

  SettingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? about;
  String? terms;

  Data.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    terms = json['terms'];
  }
}
