// ignore_for_file: void_checks

class FavoritesModel {
  bool? status;
  Data? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<FavData>? data=[];

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add( FavData.fromJson(v));
      });
    }
  }

}

class FavData {
  dynamic? id;
  ProductData? product;

  FavData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ?  ProductData.fromJson(json['product']) : null;
  }
}

class ProductData {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;


  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
