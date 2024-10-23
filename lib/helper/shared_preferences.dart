import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUsers {
  static const String _keyNpk = 'npk';
  static const String _keyPassword = 'password';
  static const String _keyNamaLengkap = 'namaLengkap';
  static const String _keyIsAdmin = 'isAdmin';

  static Future<void> saveLoginData(
    String npk,
    String password,
    String namaLengkap,
    bool isAdmin,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyNpk, npk);
    await prefs.setString(_keyPassword, password);
    await prefs.setString(_keyNamaLengkap, namaLengkap);
    await prefs.setBool(_keyIsAdmin, isAdmin);
  }

  // Set npk
  static Future<void> setNpk(String npk) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyNpk, npk);
  }

  // Set password
  static Future<void> setPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPassword, password);
  }

  // Set nama lengkap
  static Future<void> setNamaLengkap(String namaLengkap) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyNamaLengkap, namaLengkap);
  }

  // Set isAdmin
  static Future<void> setIsAdmin(bool isAdmin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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

  // Ambil npk yang disimpan
  static Future<String?> getNpk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyNpk);
  }

  // Ambil password yang disimpan
  static Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPassword);
  }

  // Hapus data login (logout)
  static Future<void> clearLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyNpk);
    await prefs.remove(_keyPassword);
  }

  // Cek apakah user sudah login
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? npk = prefs.getString(_keyNpk);
    String? token = prefs.getString(_keyPassword);
    String? namaLengkap = prefs.getString(_keyNamaLengkap);
    bool? isAdmin = prefs.getBool(_keyIsAdmin);
    return npk != null &&
        token != null &&
        namaLengkap != null &&
        isAdmin != null;
  }
}
