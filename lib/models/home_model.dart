import 'package:flutter/cupertino.dart';

// class HomeData{
//   bool? status;
//   Data? data;
//
//   HomeData.fromJson(Map<String,dynamic> json){
//     status=json["status"];
//     data=Data.fromJson(json["data"]);
//   }
// }
//
// class Data{
//  List<Banner>?  banners=[];
//  List<Product>? products=[];
//  Data.fromJson( json){
//    json["banners"].forEach((element)=>banners?.add(element));
//    json["products"].forEach((element)=>products?.add(element));
// }
// }
//
// class Banner{
//   int? id;
//   String? image;
//   Banner.fromJson(Map<String,dynamic> json){
//     id=json["id"];
//     image=json["image"];
//   }
// }
//
// class Product{
//   int? id;
//   dynamic? price;
//   dynamic? old_price;
//   dynamic? discount;
//   String? image;
//   String? name;
//   List? images;
//   bool? in_favorite;
//   bool? in_cart;
//
//   Product.fromJson(Map<String,dynamic> json){
//     id=json["id"];
//     price=json["price"];
//     old_price=json["old_price"];
//     discount=json["discount"];
//     image=json["image"];
//     name=json["name"];
//     images=json["images"];
//     in_favorite=json["in_favorite"];
//     in_cart=json["in_cart"];
//
//   }
// }







class HomeDataModel {
  bool? status;
  Null? message;
  Data? data;

  HomeDataModel({this.status, this.message, this.data});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<Banners>? banners;
  List<Product>? products;
  String? ad;

  Data({this.banners, this.products, this.ad});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(new Product.fromJson(v));
      });
    }
    ad = json['ad'];
  }


}

class Banners {
  int? id;
  String? image;
  Null? category;
  Null? product;

  Banners({this.id, this.image, this.category, this.product});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }
}

class Product {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  Product(
      {this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
        this.name,
        this.description,
        this.images,
        this.inFavorites,
        this.inCart});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}