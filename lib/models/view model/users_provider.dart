import 'package:flutter/material.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:user_painting_tools/models/services/users_service.dart';
import 'package:user_painting_tools/models/users.dart';
import 'package:user_painting_tools/helper/shared_preferences.dart';

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

  String get statusMessage => _statusMessage;
  String _statusMessage = '';

  final SimpleLogger _simpleLogger = SimpleLogger();

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void filterUsers(String query) {
    if (query.isNotEmpty) {
      _filteredUsers = _listUsers
          .where((user) =>
          user.npkUser.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      _filteredUsers = _listUsers;
    }
    notifyListeners();
  }

  // Fetch all users from Firestore
  Future<void> fetchUsers() async {
    _setLoading(true);
    try {
      _listUsers = await _usersServices.fetchAllUsers();
      _filteredUsers = _listUsers;
      _simpleLogger.info('Fetch Users Success: ${_listUsers.length} users fetched');
      notifyListeners();
    } catch (e) {
      _simpleLogger.info(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> loginUser(String npkUser, String passwordUser) async {
    _setLoading(true);
    try {
      Users? user = await _usersServices.getUserByNpk(npkUser);

      if (user?.passwordUser == passwordUser) {
        _currentUser = user;

        await SharedPreferencesUsers.saveLoginData(
          npkUser,
          passwordUser,
          _currentUser?.namaLengkap ?? "Belum Mengisi",
          _currentUser?.isAdmin ?? false,
        );

        print('User berhasil login: ${_currentUser?.namaLengkap}');
        notifyListeners();
        return true;
      } else {
        _simpleLogger.warning("Password salah.");
        return false;
      }
    } catch (e) {
      _simpleLogger.info("Login gagal: ${e.toString()}");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Fetch user data by NPK
  Future<void> fetchUserDataWithNpk(String npk) async {
    _setLoading(true);
    try {
      _currentUser = await _usersServices.getUserByNpk(npk);
      _simpleLogger.info("Data user ditemukan: ${_currentUser?.passwordUser}");
      notifyListeners();
    } catch (e) {
      _simpleLogger.info("Gagal mengambil data user: ${e.toString()}");
    } finally {
      _setLoading(false);
    }
  }

  // Update user's full name (nama lengkap)
  Future<void> updateLongName(String namaLengkap) async {
    if (_currentUser != null) {
      _setLoading(true);
      try {
        String npk = _currentUser!.npkUser;

        await _usersServices.updateLongName(npk, namaLengkap);

        _currentUser = Users(
          npkUser: _currentUser!.npkUser,
          passwordUser: _currentUser!.passwordUser,
          namaLengkap: namaLengkap,
        );
        SharedPreferencesUsers.setNamaLengkap(namaLengkap);

        _simpleLogger.info("Nama lengkap berhasil diperbarui: $namaLengkap");
        notifyListeners();
      } catch (e) {
        _simpleLogger
            .severe("Error saat mengupdate nama lengkap: ${e.toString()}");
      } finally {
        _setLoading(false);
      }
    }
  }

  // Load the current user by ID (for session management)
  Future<void> loadCurrentUser(String npk) async {
    _setLoading(true);
    try {
      _currentUser = await _usersServices.getUserByNpk(npk);
      _simpleLogger.info("Current user loaded: ${_currentUser?.namaLengkap}");
    } catch (e) {
      _simpleLogger.severe("Error loading current user: ${e.toString()}");
    } finally {
      _setLoading(false);
    }
  }

  // Add user to Firestore (Register new user)
  Future<void> addUser(String npkUser, String passwordUser) async {
    _setLoading(true);
    try {
      if (npkUser.isNotEmpty && passwordUser.isNotEmpty) {
        bool success =  await _usersServices.addDataUserToFirestore(npkUser, passwordUser);
        _statusMessage = success ? "User Berhasil Ditambahkan" : "User sudah terdaftar di database.";
      }
    } catch (e) {
      _simpleLogger.info("Gagal menambah user: ${e.toString()}");
    } finally {
      _setLoading(false);
    }
  }

  // Delete user from Firestore
  Future<void> deleteUser(String npkUser) async {
    _setLoading(true);
    try {
      await _usersServices.deleteUserOnFirestore(npkUser);
    } catch (e) {
      _simpleLogger.severe("Error deleting user: ${e.toString()}");
    } finally {
      _setLoading(false);
    }
  }
}