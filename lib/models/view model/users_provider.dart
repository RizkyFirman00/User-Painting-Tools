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

  List<Users> get listUsers => _listUsers;
  List<Users> _listUsers = [];

  Users? get currentUser => _currentUser;

  bool get isLoading => _isLoading;

  bool get isAdmin => _isAdmin;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SimpleLogger _simpleLogger = SimpleLogger();

  Future<void> fetchAllUser() async {
    _setLoading(true);
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      _listUsers = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Users.fromDocument(doc);
      }).toList();
      notifyListeners();
      _setLoading(false);
    } catch (e) {
      _simpleLogger.info(e);
      _setLoading(false);
    }
  }

  Future<bool> loginUser(String emailUser, String npkUser) async {
    _setLoading(true);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailUser.trim(), password: npkUser.trim());
      String? uid = userCredential.user?.uid;

      await _saveUserToFirestore(uid, emailUser, npkUser);
      await _fetchUserData(uid);
      await SharedPreferencesUsers.saveLoginData(
          emailUser, npkUser, _currentUser?.namaLengkap ?? "", _isAdmin);

      //HELPER
      _simpleLogger.info(userCredential.user?.email);
      _setLoading(false);
      return true;
    } catch (e) {
      _simpleLogger.info("Login Gagal: ${e.toString()}");
      _setLoading(false);
      return false;
    }
  }

  Future<void> updateNamaLengkap(String namaLengkap) async {
    _setLoading(true);
    if (_currentUser != null) {
      String? npk = _currentUser?.npkUser;

      await _firestore
          .collection('users')
          .where('npk', isEqualTo: npk)
          .limit(1)
          .get()
          .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          snapshot.docs.first.reference.update({'nama_lengkap': namaLengkap});
        }
      });

      _currentUser = Users(
        emailUser: _currentUser!.emailUser,
        npkUser: _currentUser!.npkUser,
        namaLengkap: namaLengkap,
      );
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> fetchUserDataFromFirestoreWithNpk(String npk) async {
    _setLoading(true);
    if (npk.isNotEmpty) {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('npk', isEqualTo: npk)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = snapshot.docs.first;
        _currentUser = Users.fromDocument(doc);
        _setLoading(false);
        notifyListeners();
      } else {
        print('User dengan NPK tersebut tidak ditemukan.');
        _setLoading(false);
      }
    }
  }

  // FUNCTION PENDUKUNG
  Future<void> _saveUserToFirestore(
      String? uid, String emailUser, String npkUser) async {
    if (uid == null) return;
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();

    if (!doc.exists) {
      await _firestore.collection('users').doc(uid).set({
        'email': emailUser,
        'npk': npkUser,
        'firstLogin': FieldValue.serverTimestamp(),
        'isAdmin': false,
      });
    }
  }

  Future<void> _fetchUserData(String? uid) async {
    if (uid != null) {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        _currentUser = Users.fromDocument(doc);
        _isAdmin = _currentUser!.isAdmin;
        notifyListeners();
      }
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
