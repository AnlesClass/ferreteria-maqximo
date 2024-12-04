import 'dart:convert';

import 'package:http/http.dart' as http;

class SedeService {
  final String baseURL;

  SedeService({required this.baseURL});

  Future<List<dynamic>> getSedes() async {
    final url = Uri.parse("$baseURL/sedes/get/all");
    
    try {
      //TRAER json en crudo.
      final res = await http.get(url);

      //DEVOLVER nulo si la petición arrojó un error.
      if (res.statusCode == 404) return [];

      //RETORNA una lista con todos los Json de Sede(s).
      return jsonDecode(res.body);

    } catch (err) {
      //TODO: Mensaje en pantalla
      print("DEBUG: No se pudieron cargar Sedes en el SERVICIO.");
      return [];
    }
  }
}