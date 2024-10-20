import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:user_painting_tools/helper/shared_preferences.dart';
import 'package:user_painting_tools/models/users.dart';

class UsersProvider with ChangeNotifier {
  Users? _currentUser;
  bool _isLoading = false;
  bool _isAdmin = false;

  List<Users> get listUsers =>
      _filteredUsers.isEmpty ? _listUsers : _filteredUsers;
  List<Users> _listUsers = [];
  List<Users> _filteredUsers = [];

  Users? get currentUser => _currentUser;

  bool get isLoading => _isLoading;

  bool get isAdmin => _isAdmin;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SimpleLogger _simpleLogger = SimpleLogger();

  void _setLoading(bool value) {
    _isLoading = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
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

  Future<void> fetchAllUser() async {
    _setLoading(true);
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('users').orderBy('email').get();
      _listUsers = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Users.fromDocument(doc);
      }).toList();
      _filteredUsers = _listUsers;
      notifyListeners();
    } catch (e) {
      _simpleLogger.info(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> loginUser(String emailUser, String npkUser) async {
    _setLoading(true);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailUser.trim(),
        password: npkUser.trim(),
      );
      String? uid = userCredential.user?.uid;

      await _saveUserToFirestoreWhileLogin(uid, emailUser, npkUser);
      await _fetchUserData(uid);
      await SharedPreferencesUsers.saveLoginData(
          emailUser, npkUser, _currentUser?.namaLengkap ?? "", _isAdmin);

      _simpleLogger.info(userCredential.user?.email);
      return true;
    } catch (e) {
      _simpleLogger.info("Login Gagal: ${e.toString()}");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateNamaLengkap(String namaLengkap) async {
    _setLoading(true);
    try {
      if (_currentUser != null) {
        String? npk = _currentUser?.npkUser;

        QuerySnapshot snapshot = await _firestore
            .collection('users')
            .where('npk', isEqualTo: npk)
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty) {
          await snapshot.docs.first.reference.update({
            'nama_lengkap': namaLengkap,
          });
          _currentUser = Users(
            emailUser: _currentUser!.emailUser,
            npkUser: _currentUser!.npkUser,
            namaLengkap: namaLengkap,
          );
        }
      }
    } catch (e) {
      _simpleLogger.info("Gagal mengupdate nama lengkap: ${e.toString()}");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addUserToAuth(String email, String npk) async {
    _setLoading(true);
    try {
      if (email.isNotEmpty && npk.isNotEmpty) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: npk);
        String? uid = userCredential.user?.uid;
        await _saveUserToFirestoreInAdmin(uid, email, npk);
      }
    } catch (e) {
      _simpleLogger.info("Gagal menambah user: ${e.toString()}");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchUserDataFromFirestoreWithNpk(String npk) async {
    _setLoading(true);
    try {
      if (npk.isNotEmpty) {
        QuerySnapshot snapshot = await _firestore
            .collection('users')
            .where('npk', isEqualTo: npk)
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty) {
          DocumentSnapshot doc = snapshot.docs.first;
          _currentUser = Users.fromDocument(doc);
        } else {
          _simpleLogger.info('User dengan NPK tersebut tidak ditemukan.');
        }
      }
    } catch (e) {
      _simpleLogger.info("Gagal mengambil data user: ${e.toString()}");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteUserOnAuth(String email, String npk) async {
    _setLoading(true);
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
      }

      User? userToDelete =
          (await _auth.signInWithEmailAndPassword(email: email, password: npk))
              .user;
      print('USER: $userToDelete');
      if (userToDelete != null) {
        await userToDelete.delete();
      }
    } catch (e) {
      print('Error deleting user: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _saveUserToFirestoreWhileLogin(
      String? uid, String emailUser, String npkUser) async {
    if (uid == null) return;
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) {
        await _firestore.collection('users').doc(uid).set({
          'email': emailUser,
          'npk': npkUser,
          'firstLogin': FieldValue.serverTimestamp(),
          'isAdmin': false,
        });
      }
    } catch (e) {
      _simpleLogger.info("Gagal menyimpan user ke Firestore: ${e.toString()}");
    }
  }

  Future<void> _saveUserToFirestoreInAdmin(
      String? uid, String emailUser, String npkUser) async {
    if (uid == null) return;
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) {
        await _firestore.collection('users').doc(uid).set({
          'email': emailUser,
          'npk': npkUser,
          'isAdmin': false,
        });
      }
    } catch (e) {
      _simpleLogger.info("Gagal menyimpan user ke Firestore: ${e.toString()}");
    }
  }

  Future<void> _fetchUserData(String? uid) async {
    if (uid != null) {
      try {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(uid).get();
        if (doc.exists) {
          _currentUser = Users.fromDocument(doc);
          _isAdmin = _currentUser!.isAdmin;
          notifyListeners();
        }
      } catch (e) {
        _simpleLogger.info("Gagal mengambil data user: ${e.toString()}");
      }
    }
  }
}
