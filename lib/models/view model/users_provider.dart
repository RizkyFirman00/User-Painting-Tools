import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_painting_tools/models/services/users_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:user_painting_tools/helper/shared_preferences.dart';
import 'package:user_painting_tools/models/users.dart';

class UsersProvider with ChangeNotifier {
  final UsersServices _usersServices = UsersServices();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final bool _isAdmin = false;

  bool get isAdmin => _isAdmin;

  List<Users> _listUsers = [];

  List<Users?> get listUsers =>
      _filteredUsers.isEmpty ? _listUsers : _filteredUsers;

  Users? _currentUser;

  Users? get currentUser => _currentUser;

  List<Users?> _filteredUsers = [];

  List<Users?> get filteredUser => _filteredUsers;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SimpleLogger _simpleLogger = SimpleLogger();

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void filterUsers(String query) {
    if (query.isNotEmpty) {
      _filteredUsers = _listUsers
          .where((user) =>
              user.emailUser.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      _filteredUsers = _listUsers;
    }
    notifyListeners();
  }

  // User Sevices
  Future<void> fetchUsers() async {
    _setLoading(true);
    try {
      _listUsers = await _usersServices.fetchAllUsers();
      _filteredUsers = _listUsers;
      notifyListeners();
    } catch (e) {
      _simpleLogger.info(e);
    } finally {
      _setLoading(false);
    }
  }

  // User Sevices
  Future<bool> loginUser(String emailUser, String npkUser) async {
    _setLoading(true);
    try {
      UserCredential? userCredential =
          await _usersServices.loginUser(emailUser, npkUser);
      _simpleLogger.info(userCredential?.user?.email);

      if (userCredential != null) {
        String uid = userCredential.user!.uid;

        _currentUser = await _usersServices.getUserById(uid);
        await SharedPreferencesUsers.saveLoginData(
          emailUser,
          npkUser,
          _currentUser?.namaLengkap ?? "Belum Mengisi",
          _currentUser?.isAdmin ?? false,
        );

        print(
            'Admin User Provider: ${_currentUser?.isAdmin}, ${_currentUser?.namaLengkap}');
        notifyListeners();
      }
      return true;
    } catch (e) {
      _simpleLogger.info("Login Gagal: ${e.toString()}");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // User Sevices
  Future<void> fetchUserDataWithNpk(String npk) async {
    _setLoading(true);
    try {
      _currentUser = await _usersServices.getUserByNpk(npk);
      _simpleLogger.info("CURENT USER NPK: ${_currentUser?.npkUser}");
        } catch (e) {
      _simpleLogger.info("Gagal mengambil data user: ${e.toString()}");
    } finally {
      _setLoading(false);
    }
  }

// User Sevices
  Future<void> updateLongName(String namaLengkap) async {
    if (_currentUser != null) {
      _setLoading(true);
      try {
        String npk = _currentUser!.npkUser;

        await _usersServices.updateLongName(npk, namaLengkap);

        _currentUser = Users(
          emailUser: _currentUser!.emailUser,
          npkUser: _currentUser!.npkUser,
          namaLengkap: namaLengkap,
        );
        SharedPreferencesUsers.setNamaLengkap(namaLengkap);

        _simpleLogger.info("Nama lengkap berhasil diperbarui: $namaLengkap");
      } catch (e) {
        _simpleLogger
            .severe("Error saat mengupdate nama lengkap: ${e.toString()}");
      } finally {
        _setLoading(false);
      }
    }
  }

// User Sevices
  Future<void> loadCurrentUser(String uid) async {
    _setLoading(true);
    try {
      _currentUser = await _usersServices.getUserById(uid);
    } catch (e) {
      _simpleLogger.severe("Error loading current user: ${e.toString()}");
    } finally {
      _setLoading(false);
    }
  }

  // User Sevices
  Future<void> addUserToAuth(String email, String npk) async {
    _setLoading(true);
    try {
      if (email.isNotEmpty && npk.isNotEmpty) {
        await _usersServices.addDataUserToAuth(email, npk);
      }
    } catch (e) {
      _simpleLogger.info("Gagal menambah user: ${e.toString()}");
    } finally {
      _setLoading(false);
    }
  }

  // User Services
  Future<void> deleteUserOnAuth(String email, String npk) async {
    _setLoading(true);
    try {
      _usersServices.deleteUserOnAuth(email, npk);
    } catch (e) {
      print('Error deleting user: $e');
    } finally {
      _setLoading(false);
    }
  }
}
