import 'dart:convert';

import 'package:ostad_ts/Models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static String? UserToken;
  static UserModel? userData;

  static Future saveData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("token", token);
    sharedPreferences.setString("user_data", jsonEncode(model.toJson()));
    UserToken = token;
    userData = model;
  }

  static Future getUserData()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String ? token = sharedPreferences.getString('token');
    String ? user = sharedPreferences.getString('user_data');
    if (token != null && user != null) {
      UserToken = token;
      userData = UserModel.fromJson(jsonDecode(user));
      return true;
    } else {
      return false;
    }

  }

  static Future isUserLogin()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String ? token = sharedPreferences.getString('token');
    if (token != null) {
      UserToken = token;
      return true;
    } else {
      return false;
    }
  }

  static Future logout()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }


}
