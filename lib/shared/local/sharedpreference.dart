import 'package:shared_preferences/shared_preferences.dart';

 class CachHelper{
 static SharedPreferences? sharedPreferences;
  static init()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }
  static Future<dynamic> setBoolData({required key,required value,})async{
   return await sharedPreferences!.setBool(key, value);
  }

 static Future<dynamic> setStringData({required key,required value,})async{
   return await sharedPreferences!.setString(key, value);
 }

  static Future <dynamic> getData({required key})async{
    return await sharedPreferences!.get(key);
  }

 static Future <dynamic> removeData({required key})async{
   return await sharedPreferences!.remove(key);
 }
}


