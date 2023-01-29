import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences?  sharedPrefrences  ;

  static init () async {
    sharedPrefrences = await SharedPreferences.getInstance();
  }

  static Future<bool?> putData (
  {
    required String key ,
    required bool value ,
  })async{
    return await sharedPrefrences?.setBool(key, value );
  }

  static bool? getData (
      {
        required String key ,
      }){
    return  sharedPrefrences?.getBool(key);
  }


}