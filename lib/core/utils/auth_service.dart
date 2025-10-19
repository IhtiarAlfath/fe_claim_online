import 'dart:convert';

import 'package:claim_online/features/authentication/domain/entities/data_user_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static String tokenKey = 'auth_token';
  static const String userKey = 'auth_user';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  static Future<void> saveUser(DataUserToken user) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(user.toJson());
    await prefs.setString(userKey, jsonString);
  }

  static Future<DataUserToken?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(userKey);
    if (jsonString == null) return null;
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return DataUserToken.fromJson(jsonMap);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    await prefs.remove(userKey);
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}
