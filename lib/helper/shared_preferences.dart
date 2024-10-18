import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUsers {
  static const String _keyEmail = 'email';
  static const String _keyNpk = 'npk';
  static const String _keyNamaLengkap = 'namaLengkap';
  static const String _keyIsAdmin = 'isAdmin';

  static Future<void> saveLoginData(
      String email, String npk, String namaLengkap, bool isAdmin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyNpk, npk);
    await prefs.setString(_keyNamaLengkap, namaLengkap);
    await prefs.setBool(_keyIsAdmin, isAdmin);
  }

  // Ambil isAdmin yang disimpan
  static Future<String?> getNamaLengkap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyNamaLengkap);
  }

  // Ambil isAdmin yang disimpan
  static Future<bool?> getIsAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsAdmin);
  }

  // Ambil email yang disimpan
  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  // Ambil npk yang disimpan
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
    String? namaLengkap = prefs.getString(_keyNamaLengkap);
    String? isAdmin = prefs.getString(_keyNpk);
    return email != null &&
        token != null &&
        namaLengkap != null &&
        isAdmin != null;
  }
}
