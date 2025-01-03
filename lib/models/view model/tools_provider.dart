import 'package:flutter/material.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:user_painting_tools/models/services/tools_service.dart';
import 'package:user_painting_tools/models/tools.dart';

class ToolsProvider with ChangeNotifier {
  final ToolsServices toolsServices = ToolsServices();
  final SimpleLogger _simpleLogger = SimpleLogger();

  // Loading Param
  bool get isLoading => _isLoading;
  bool _isLoading = false;

  // List User Param
  List<Tools?> get filteredUser => _filteredTools;
  List<Tools> get listTools => _filteredTools.isEmpty ? _listTools : _filteredTools;
  List<Tools> _listTools = [];
  List<Tools> _filteredTools = [];

  // Instance Tools Param
  Tools? _selectedTool;
  Tools? get selectedTool => _selectedTool;

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
      notifyListeners();
    } else {
      _filteredTools = _listTools;
    }
    notifyListeners();
  }

  Future<void> updateTool(String idTools, String nameTools, int qtyTools) async {
    _setLoading(true);
    try {
      if (idTools.isNotEmpty && nameTools.isNotEmpty && qtyTools != 0) {
        await toolsServices.updateToolInFirestore(idTools, nameTools, qtyTools);
        _simpleLogger.info("Tool $nameTools berhasil diperbarui.");
        await fetchTools();
      }
    } catch (e) {
      _simpleLogger.severe("Gagal memperbarui tool: ${e.toString()}");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateToolWithQty(String idTools, String nameTools, int qtyTools, int newQtyTools, int qtyAvailTools) async {
    _setLoading(true);
    try {
      if (idTools.isNotEmpty && nameTools.isNotEmpty && newQtyTools != 0) {
        int newQtyCalculated = newQtyTools - qtyTools + qtyAvailTools;
        await toolsServices.updateToolInFirestoreWithNewQty(idTools, nameTools, newQtyTools, newQtyCalculated);
        _simpleLogger.info("Tool $nameTools berhasil diperbarui.");
        await fetchTools();
      }
    } catch (e) {
      _simpleLogger.severe("Gagal memperbarui tool: ${e.toString()}");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addToolToFirestore(String idTools, String nameTools, int qtyTools) async {
    _setLoading(true);
    try {
      if (idTools.isNotEmpty &&
          nameTools.isNotEmpty &&
          qtyTools != 0) {
        await toolsServices.addToolsToFirestore(idTools, nameTools, qtyTools);
      }
      notifyListeners();
    } catch (e) {
      _simpleLogger.info("Gagal menyimpan user ke Firestore: ${e.toString()}");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchTools() async {
    _setLoading(true);
    try {
      _listTools = await toolsServices.fetchTools();
      _filteredTools = _listTools;
      notifyListeners();
    } catch (e) {
      _simpleLogger.info(e);
    } finally {
      _setLoading(false);
    }
  }

  // Fetch tool data by NPK
  Future<void> fetchToolDataWithId(String toolsId) async {
    _setLoading(true);
    try {
       _selectedTool = await toolsServices.getToolById(toolsId);
      _simpleLogger.info("Data user ditemukan: ${_selectedTool?.namaAlat}");
       notifyListeners();
    } catch (e) {
      _simpleLogger.info("Gagal mengambil data user: ${e.toString()}");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteTools(String idTools, String nameTools) async {
    _setLoading(true);
    try {
      await toolsServices.deleteTools(idTools, nameTools);
      _simpleLogger.info("Success delete tool $nameTools");
      await fetchTools();
      notifyListeners();
    } catch(e) {
      _simpleLogger.severe('Error deleting user: $e');
    } finally {
      _setLoading(false);
    }
  }

}