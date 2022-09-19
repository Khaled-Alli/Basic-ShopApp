import 'package:dio/dio.dart';
class DioHelper{
 static  Dio? dio;
 static init(){
  dio=Dio(BaseOptions(
 baseUrl: "https://student.valuxapps.com/api/",
   receiveDataWhenStatusError: true,
  ));
 }

 static Future getData({required url,query,token ,lang="en"}) async{
   dio?.options.headers={
     "Authorization":token,
     "lang":lang,
     "Content-Type":"application/json",
   };
   return await dio!.get(url,queryParameters: query,);
 }

 static Future postData({required url,required data,token,lang="en"}) async{
   dio?.options.headers={
     "Authorization":token??null,
     "lang":lang,
     "Content-Type":"application/json",
   };
  return await dio?.post(url,data: data);
 }

}