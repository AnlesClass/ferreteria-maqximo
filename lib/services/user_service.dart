import 'dart:convert';
import 'package:app_ferreteria/models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl;

  UserService(this.baseUrl);

  Future<bool> addUser(User user) async {
    final url = Uri.parse('$baseUrl/usuarios/crud/add');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Error al hacer la solicitud: $e');
      return false;
    }
  }
}
