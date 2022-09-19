class GetFavoriteDataModel {
  bool? status;
  Null? message;
  Dataa? dataa;
  GetFavoriteDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    dataa = json['data'] != null ? new Dataa.fromJson(json['data']) : null;
  }
}

class Dataa {
  int? currentPage;
  List<Data>? data;
  Dataa.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  Product? product;
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}