import 'dart:convert';

import 'package:app_ferreteria/models/models.dart';
import 'package:http/http.dart' as http;

class ExistenciaService {
  final String baseURL;

  ExistenciaService({required this.baseURL});

  Future<bool> addExistence(Existencia existencia) async{
    final url = Uri.parse("$baseURL/existencias/crud/add");
    
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: existenciaToJson(existencia)
      );

      if (response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 500) {
        return false;
      }
    } catch (err) {
      return false;
    }
    return false;
  }

  Future<List<dynamic>> getExistenceDetails(String existenceName, int idSede) async{
    final url = Uri.parse('$baseURL/existencias/get/details?existenciaNombre=$existenceName&idSede=$idSede');

    try {
      final res = await http.get(url);
      
      if (res.statusCode == 404) return [];

      return jsonDecode(res.body);

    } catch (err) {
      print("Error al listar los detalles (precio y cantidad) de una existencia: $err");
      return [];
    }
  }

  Future<List<dynamic>> getAllExistences(int idSede, String nombre) async{
    final url = Uri.parse('$baseURL/existencias/get/all?idSede=$idSede&name=$nombre');

    try {
      final res = await http.get(url);
      
      if (res.statusCode == 404) return [];

      return jsonDecode(res.body);
    } catch (err) {
      print("Error al listar las Existencias: $err");
      return [];
    }
  }
}