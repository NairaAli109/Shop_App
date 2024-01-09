// ignore_for_file: void_checks
class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  CategoriesDataModel.fromJson(json['data']) : null;
  }
}

class CategoriesDataModel {
  List<DataModel>? data=[];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(DataModel.fromJson(v));
      });
    }
  }
}

class DataModel {
  dynamic id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
