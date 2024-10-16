import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUsers {
  static const String _keyEmail = 'email';
  static const String _keyNpk = 'npk';

  static Future<void> saveLoginData(String email, String npk) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyNpk, npk);
  }

  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  // Ambil token yang disimpan
  static Future<String?> getNpk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyNpk);
  }

  // Hapus data login (logout)
  static Future<void> clearLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyNpk);
  }

  // Cek apakah user sudah login
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString(_keyEmail);
    String? token = prefs.getString(_keyNpk);
    return email != null && token != null;
  }
}