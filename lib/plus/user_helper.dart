import 'package:shared_preferences/shared_preferences.dart';
import 'package:ahri_manager/data/user_information.dart';
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

  List<user_information> getuserinformation() {
    List<user_information> userinformations = [];
    Set<String> keys=prefs.getKeys();
    keys.forEach((String key) {
      user_information information = user_information.fromJson(json.decode(prefs.getString(key)??''));
      userinformations.add(information);
    });
    return userinformations;
  }
}