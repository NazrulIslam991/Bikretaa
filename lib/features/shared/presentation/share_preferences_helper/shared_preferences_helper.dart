import 'dart:convert';

import 'package:bikretaa/features/auth/presentation/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _userKey = 'user_info';
  static const String _themeKey = 'is_dark_mode';
  static const String _languageKey = 'app_language';
  static const String keyQuickActions = "quick_actions";
  static const String _calcHistoryKey = "calc_history";
  static const String _notesKey = "notes_data";

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

  // Save selected language ('en' or 'bn')
  static Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  // Get saved language
  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'en';
  }

  // Save selected quick actions indexes
  static Future<void> saveQuickActions(List<int> indexes) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      keyQuickActions,
      indexes.map((e) => e.toString()).toList(),
    );
  }

  // Get saved quick actions indexes
  static Future<List<int>?> getQuickActions() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? saved = prefs.getStringList(keyQuickActions);
    if (saved != null) {
      return saved.map((e) => int.parse(e)).toList();
    }
    return null;
  }

  // Save calculation history list
  static Future<void> saveCalcHistory(List<String> historyList) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_calcHistoryKey, historyList);
  }

  // Load calculation history list
  static Future<List<String>> loadCalcHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? saved = prefs.getStringList(_calcHistoryKey);
    if (saved != null) return saved;
    return [];
  }

  // Clear calculation history
  static Future<void> clearCalcHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_calcHistoryKey);
  }

  // Save notes
  static Future<void> saveNotes(List<Map<String, String>> notes) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> encoded = notes.map((e) => json.encode(e)).toList();
    await prefs.setStringList(_notesKey, encoded);
  }

  // Load notes
  static Future<List<Map<String, String>>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? saved = prefs.getStringList(_notesKey);
    if (saved != null) {
      return saved
          .map((e) => Map<String, String>.from(json.decode(e)))
          .toList();
    }
    return [];
  }

  // Clear notes
  static Future<void> clearNotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_notesKey);
  }
}
