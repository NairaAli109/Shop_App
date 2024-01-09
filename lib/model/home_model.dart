// ignore_for_file: void_checks

class HomeModel
{
  bool?status;
  HomeDataModel? data;

  HomeModel.fromJson(Map <String,dynamic>json){
    status=json['status'];
    data = json['data']!=null ? HomeDataModel.fromJson(json['data']) : null ;
  }
}

class HomeDataModel
{
  List<BannerModel>?banners=[];
  List<ProductDetailsData>?products=[];

  HomeDataModel.fromJson(Map<String,dynamic>json)
  {
    if(json['banners']!= null){
      json['banners'].forEach((element) {
        banners!.add(BannerModel.fromJson(element));
      });
    }
    if(json['products']!= null){
      json['products'].forEach((element) {
        products!.add(ProductDetailsData.fromJson(element));
      });
    }
  }
}

class BannerModel
{
  int?id;
  String?image;
  BannerModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    image=json['image'];
  }
}

class ProductDetailsData {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;
  List<String?>? images;

  ProductDetailsData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    price = json["price"]?.toInt();
    oldPrice = json["old_price"]?.toInt();
    discount = json["discount"]?.toInt();
    image = json["image"]?.toString();
    name = json["name"]?.toString();
    description = json["description"]?.toString();
    inFavorites = json["in_favorites"];
    inCart = json["in_cart"];
    if (json["images"] != null) {
      final v = json["images"];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      images = arr0;
    }
  }
}
