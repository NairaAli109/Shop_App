class SearchModel {
  bool? status;
  SearchData? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  SearchData.fromJson(json['data']) : null;
  }

}

class SearchData {
  List<Data>? data;

  SearchData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }
}

class Data {
  dynamic id;
  dynamic price;
  String? image;
  String? name;
  String? description;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
