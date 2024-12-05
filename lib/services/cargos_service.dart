import 'dart:convert';

import 'package:app_ferreteria/models/models.dart';
import 'package:http/http.dart' as http;

class CargosService {
  final String baseURL;
  CargosService({required this.baseURL});

  Future<List<dynamic>> getCargos() async {
    final url = Uri.parse("$baseURL/cargos/get/all");
    try {
      print("DEBUG: Realizando solicitud a $url");
      final res = await http.get(url);

      // Maneja códigos de estado diferentes a 200
      if (res.statusCode != 200) {
        print(
            "DEBUG: Error al obtener cargos, código de estado: ${res.statusCode}");
        return [];
      }

      // Decodifica la respuesta y asegúrate de que sea una lista
      final decoded = jsonDecode(res.body);
      if (decoded is List) {
        return decoded;
      } else {
        print("DEBUG: Respuesta inesperada de la API. Se esperaba una lista.");
        return [];
      }
    } catch (err) {
      print("DEBUG: No se pudieron cargar cargos en el SERVICIO. Error: $err");
      return [];
    }
  }
}
