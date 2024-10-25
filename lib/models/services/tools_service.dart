import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:user_painting_tools/models/tools.dart';

class ToolsServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SimpleLogger _simpleLogger = SimpleLogger();

  Future<void> addToolsToFirestore(
      String idBarang, String namaBarang, int kuantitasBarang) async {
    try {
      if (idBarang.isNotEmpty &&
          namaBarang.isNotEmpty &&
          kuantitasBarang != 0) {
        DocumentSnapshot doc =
            await _firestore.collection('tools').doc(idBarang).get();
        if (!doc.exists) {
          await _firestore.collection('tools').doc(idBarang).set({
            'id_alat': idBarang,
            'nama_alat': namaBarang,
            'kuantitas_alat': kuantitasBarang,
            'kuantitas_alat_tersedia': kuantitasBarang,
          });
        }
      }
    } catch (e) {
      _simpleLogger.severe("Error adding user to Auth: ${e.toString()}");
    }
  }

  Future<List<Tools>> fetchTools() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection('tools').get();
      List<Tools> listTools = querySnapshot.docs.map((doc) {
        return Tools.fromDocument(doc);
      }).toList();
      return listTools;
    } catch (e) {
      _simpleLogger.info(e);
      return [];
    }
  }

  Future<void> updateToolInFirestore(
      String idAlat, String namaAlat, int kuantitasAlat) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('tools').doc(idAlat).get();
      if (doc.exists) {
        await _firestore.collection('tools').doc(idAlat).update({
          'nama_alat': namaAlat,
        });
        _simpleLogger.info("Tool $namaAlat berhasil diperbarui.");
      } else {
        throw Exception("Tool tidak ditemukan.");
      }
    } catch (e) {
      _simpleLogger.severe("Error updating tool in Firestore: ${e.toString()}");
    }
  }

  Future<void> updateToolInFirestoreWithNewQty(String idAlat, String namaAlat,
      int kuantitasAlatBaru, int kuantitasAlatTersediaBaru) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('tools').doc(idAlat).get();
      if (doc.exists) {
        await _firestore.collection('tools').doc(idAlat).update({
          'nama_alat': namaAlat,
          'kuantitas_alat': kuantitasAlatBaru,
          'kuantitas_alat_tersedia': kuantitasAlatTersediaBaru,
        });
        _simpleLogger.info("Tool $namaAlat berhasil diperbarui.");
      } else {
        throw Exception("Tool tidak ditemukan.");
      }
    } catch (e) {
      _simpleLogger.severe("Error updating tool in Firestore: ${e.toString()}");
    }
  }

  Future<Tools> getToolById(String toolId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('tools')
          .where('id_alat', isEqualTo: toolId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = snapshot.docs.first;
        return Tools.fromDocument(doc);
      } else {
        throw Exception("Barang tidak ditemukan");
      }
    } catch (e) {
      throw Exception("Error fetching tool: ${e.toString()}");
    }
  }

  Future<void> deleteTools(String idAlat, String namaAlat) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('tools')
          .where('id_alat', isEqualTo: idAlat)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
        _simpleLogger.info('User deleted from Firestore: $idAlat');
      }
    } catch (e) {
      _simpleLogger.severe('Error deleting user: $e');
    }
  }
}
