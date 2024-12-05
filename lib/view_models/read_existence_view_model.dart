import 'package:app_ferreteria/services/services.dart';
import 'package:flutter/material.dart';

class ReadExistenceViewModel extends ChangeNotifier {

  final TextEditingController nombreExistencia = TextEditingController();
  List<dynamic> existences = [];
  final ExistenciaService _existenciaService;

  ReadExistenceViewModel(this._existenciaService){
    // TODO: RELLENO GENÉRICO
    getExistences(1, "");
  }

  Future<void> getExistences(int idSede, String nombreProducton) async {
    try {
      final response = await _existenciaService.getAllExistences(idSede, nombreProducton);
      
      if (response.isEmpty) existences = [];

      existences = response;
    } catch (err) {
      print('Error al hacer la solicitud "getExistences" => $err');
      existences = [];
    } finally {
      notifyListeners();
    }
  }

  
}