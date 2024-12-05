import 'package:app_ferreteria/services/services.dart';
import 'package:flutter/material.dart';

class ReadExistenceViewModel extends ChangeNotifier {

  final TextEditingController nombreExistencia = TextEditingController();
  List<dynamic> existences = [];
  final ExistenciaService _existenciaService;

  ReadExistenceViewModel(this._existenciaService){
    getExistences(1);
  }

  Future<void> getExistences(int idSede) async {
    try {
      final response = await _existenciaService.getAllExistences(idSede);
      
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