class UserDataModel {
  bool? status;
  String? message;
  Data? data;

  UserDataModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.message = json["message"];
    this.data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  Data.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.email = json["email"];
    this.phone = json["phone"];
    this.image = json["image"];
    this.points = json["points"];
    this.credit = json["credit"];
    this.token = json["token"];
  }
}
