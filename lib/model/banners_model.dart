// ignore_for_file: void_checks

class BannersModel {
  bool? status;
  List<Data>? data=[];

  BannersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      }
      );
    }
  }
}

class Data {
  int? id;
  String? image;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}
