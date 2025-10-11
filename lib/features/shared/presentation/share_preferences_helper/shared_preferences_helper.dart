import 'dart:convert';

import 'package:bikretaa/features/auth/presentation/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _userKey = 'user_info';
  static const String _themeKey = 'is_dark_mode';

  // Save UserModel to SharedPreferences
  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = json.encode(user.toMap());
    await prefs.setString(_userKey, userJson);
  }

  // Get UserModel from SharedPreferences
  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      final Map<String, dynamic> userMap = json.decode(userJson);
      return UserModel.fromMap(userMap);
    }
    return null;
  }

  //Remove user from SharedPreferences (on logout)
  static Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // Check if user exists in SharedPreferences
  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userKey);
  }

  // Save theme mode
  static Future<void> saveThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDarkMode);
  }

  // Get theme mode
  static Future<bool> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false; // default: light
  }
}
