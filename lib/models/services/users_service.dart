import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:user_painting_tools/models/users.dart';

class UsersServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SimpleLogger _simpleLogger = SimpleLogger();

  Future<void> addDataUserToFirestore(String npkUser, String passwordUser) async {
    try {
      await _firestore.collection('users').add({
        'npk': npkUser,
        'password': passwordUser,
        'isAdmin': false,
      });
    } catch (e) {
      _simpleLogger.severe("Error adding user to Firestore: ${e.toString()}");
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

  Future<void> deleteUserOnFirestore(String npk) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('npk', isEqualTo: npk)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
        _simpleLogger.info('User deleted from Firestore: $npk');
      } else {
        _simpleLogger.warning('User dengan NPK $npk tidak ditemukan.');
      }
    } catch (e) {
      _simpleLogger.severe('Error deleting user: ${e.toString()}');
    }
  }
}
