import 'dart:convert';

import 'package:http/http.dart' as http;

class SedeService {
  final String baseURL;

  SedeService({required this.baseURL});

  Future<List<dynamic>> getSedes() async {
    final url = Uri.parse("$baseURL/sedes/get/all");

    try {
      print("DEBUG: Realizando solicitud a $url");
      final res = await http.get(url);

      if (res.statusCode == 404) return [];

      return jsonDecode(res.body);
    } catch (err) {
      print("DEBUG: No se pudieron cargar Sedes en el SERVICIO.");
      return [];
    }
  }
}
