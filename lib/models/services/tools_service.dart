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
}
