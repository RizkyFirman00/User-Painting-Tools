import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:user_painting_tools/models/users.dart';

class UsersProvider with ChangeNotifier {
  List<Users> _users = [];

  Users? _currentUser;

  Users? get currentUser => _currentUser;

  List<Users> get users => _users;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final SimpleLogger _simpleLogger = SimpleLogger();

  Future<bool> loginUser(String emailUser, String npkUser) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailUser.trim(), password: npkUser.trim());
      _simpleLogger.info(userCredential.user?.email);
      await _fetchUserData(userCredential.user?.email);
      return true;
    } catch (e) {
      _simpleLogger.info("Login Gagal: ${e.toString()}");
      return false;
    }
  }

  Future<void> _fetchUserData(String? email) async {
    if (email != null) {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(email).get();
      if (doc.exists) {
        _currentUser = Users.fromDocument(doc);
        notifyListeners();
      }
    }
  }

  Future<void> fetchCurrentUser() async {
    String? email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      DocumentSnapshot doc = await _firestore.collection('users').doc(email).get();
      if (doc.exists) {
        _currentUser = Users.fromDocument(doc);
        notifyListeners();
      }
    }
  }

}
