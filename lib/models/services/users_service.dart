import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:user_painting_tools/models/users.dart';

class UsersServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SimpleLogger _simpleLogger = SimpleLogger();

  Future<void> addDataUserToAuth(String emailUser, String npkUser) async {
    try {
      if (emailUser.isNotEmpty && npkUser.isNotEmpty) {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
                email: emailUser, password: npkUser);
        String? userId = userCredential.user?.uid;
        addDataUserToFirestore(userId, emailUser, npkUser);
        print('Data user credential: $userCredential');
      }
    } catch (e) {
      _simpleLogger.severe("Error adding user to Auth: ${e.toString()}");
    }
  }

  Future<void> addDataUserToFirestore(String? userId, String emailUser, String npkUser) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'email': emailUser,
        'npk': npkUser,
        'isAdmin': false,
      });
    } catch (e) {
      _simpleLogger.severe("Error add data to firestore: ${e.toString()}");
    }
  }

  Future<Users> getUserById(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return Users.fromDocument(doc);
      } else {
        throw Exception("User tidak ditemukan");
      }
    } catch (e) {
      throw Exception("Error fetching user: ${e.toString()}");
    }
  }

  Future<Users> getUserByNpk(String npk) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('npk', isEqualTo: npk)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = snapshot.docs.first;
        return Users.fromDocument(doc);
      } else {
        throw Exception("User tidak ditemukan");
      }
    } catch (e) {
      throw Exception("Error fetching user: ${e.toString()}");
    }
  }

  Future<void> updateLongName(String npk, String namaLengkap) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('npk', isEqualTo: npk)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs.first.reference.update({
          'nama_lengkap': namaLengkap,
        });
        _simpleLogger.info('Nama lengkap berhasil diupdate untuk NPK: $npk');
      } else {
        _simpleLogger.warning('User dengan NPK $npk tidak ditemukan.');
      }
    } catch (e) {
      _simpleLogger.severe('Gagal mengupdate nama lengkap: ${e.toString()}');
    }
  }

  Future<UserCredential?> loginUser(String emailUser, String npkUser) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailUser,
        password: npkUser,
      );
      String? userId = userCredential.user?.uid;

      if (userId != null) {
        DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
        if (!doc.exists) {
          await _firestore.collection('users').doc(userId).set({
            'email': emailUser,
            'npk': npkUser,
            'firstLoginAt': FieldValue.serverTimestamp(),
            'isAdmin': false,
          });
        }
      }
      return userCredential;
    } catch (e) {
      _simpleLogger.severe("Error logging in: ${e.toString()}");
      return null;
    }
  }

  Future<List<Users>> fetchAllUsers() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection('users').get();
      _simpleLogger.info('Data Snapshot FetchAllUser: $querySnapshot');
      List<Users> usersList = querySnapshot.docs.map((doc) {
        return Users.fromDocument(doc);
      }).toList();
      return usersList;
    } catch (e) {
      _simpleLogger.severe("Error fetching users: ${e.toString()}");
      return [];
    }
  }
}
