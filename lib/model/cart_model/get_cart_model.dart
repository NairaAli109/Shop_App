// ignore_for_file: void_checks

class GetCartModel {
  bool? status;
  Data? data;

  GetCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<CartItems>? cartItems;
  dynamic total;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add( CartItems.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class CartItems {
  dynamic id;
  dynamic quantity;
  Product? product;


  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ?  Product.fromJson(json['product']) : null;
  }

}

class Product {
  dynamic id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}

