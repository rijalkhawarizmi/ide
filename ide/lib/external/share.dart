import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class Shared {
  static sharedPref({UserModel? userModel ,String? accessTokens}) async {
    UserModel userModels = UserModel(
        id: userModel?.id,
        email: userModel?.email,
        clientId: userModel?.clientId,
        name: userModel?.name,
        clientSecret: userModel?.clientSecret,
        staticToken: userModel?.staticToken,
        isActive: userModel?.isActive,
        accessToken: accessTokens);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('usermodel', jsonEncode(userModels.toJson()));
  }

  static Future<UserModel>? getShared() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data =
        await jsonDecode(prefs.getString('usermodel') ?? "");
    UserModel userss = UserModel.fromJson(data);
    return userss;
  }

  static removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('usermodel');
  }

  //how print
}
