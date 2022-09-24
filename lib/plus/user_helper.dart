import 'package:shared_preferences/shared_preferences.dart';
import 'package:ahri_manager/data/user_data.dart';
import 'dart:convert';

class UserHelper{
  static late SharedPreferences prefs;

  Future init() async{
    prefs = await SharedPreferences.getInstance();
  }
  Future writeusesinformation(user_information user_information) async{
    prefs.setString(
        user_information.id.toString(), json.encode(user_information.toJson()));
  }
}