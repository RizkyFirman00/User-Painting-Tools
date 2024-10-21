import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:user_painting_tools/models/tools.dart';

class ToolsProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SimpleLogger _simpleLogger = SimpleLogger();

  // Loading Param
  bool get isLoading => _isLoading;
  bool _isLoading = false;

  // List User Param
  List<Tools?> get filteredUser => _filteredTools;
  List<Tools> get listUsers => _filteredTools.isEmpty ? _listTools : _filteredTools;
  List<Tools> _listTools = [];
  List<Tools> _filteredTools = [];

  void _setLoading(bool value) {
    _isLoading = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void filterTools(String query) {
    if (query.isNotEmpty) {
      _filteredTools = _listTools
          .where((tool) =>
          tool.namaAlat.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      _filteredTools = _listTools;
    }
    notifyListeners();
  }

  Future<void> addToolToFirestore(String idTools, String nameTools, String qtyTools) async {
    try {
      DocumentSnapshot doc =
      await _firestore.collection('tools').doc(idTools).get();
      if (!doc.exists) {
        await _firestore.collection('tools').doc(idTools).set({
          'id_alat': idTools,
          'nama_alat': nameTools,
          'kuantitas_alat': qtyTools,
        });
      }
    } catch (e) {
      _simpleLogger.info("Gagal menyimpan user ke Firestore: ${e.toString()}");
    }
  }

  Future<void> fetchAllTools() async {
    _setLoading(true);
    try {
      QuerySnapshot querySnapshot =
      await _firestore.collection('tools').orderBy('nama_alat').get();
      _listTools = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Tools.fromDocument(doc);
      }).toList();
      _filteredTools = _listTools;
      notifyListeners();
    } catch (e) {
      _simpleLogger.info(e);
    } finally {
      _setLoading(false);
    }
  }

}