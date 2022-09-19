class CategoryModel{
  bool? status;
  CateDataModel? data;

  CategoryModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    data =CateDataModel.fromJsom(json["data"]);
  }
}

class CateDataModel{
  int? current_page;
  List<CateData>? data=[];

  CateDataModel.fromJsom(Map<String,dynamic>json){
    current_page=json["current_page"];
    json["data"].forEach((elemnt)=>data?.add(CateData.fromJson(elemnt)));
  }

}

class CateData{
  int? id;
  String? name;
  String? image;

  CateData.fromJson(Map<String,dynamic> json){
    id=json["id"];
    name=json["name"];
    image=json["image"];
  }
}