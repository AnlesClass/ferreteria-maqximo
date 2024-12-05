import 'dart:convert';
import 'package:app_ferreteria/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl;

  UserService(this.baseUrl);

// Funcion para el agregado de Usuario  (Registro)  -> retorna un booleano que verifica si se agrego un Usuario
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

  // Funcion para el login de usuario (Login) -> Retorna una lista con información del usuario de 1 elemento con información del Usuario.
  // Si no encuentra al usuario devuelve vacío.
  Future<Map<dynamic, dynamic>> loginUser({TextEditingController? usuarioController, TextEditingController? contraseniaController}) async {
    try {
      final response = await http.get(
        Uri.parse(
          "$baseUrl/usuarios/valid/email?email=${usuarioController?.text}&password=${contraseniaController?.text}",
        ),
      );

      if (response.statusCode == 404) return {};

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null && data['IDUSUARIO'] != null) {
          return data; // Inicio de sesión exitoso
        }
      }

      return {}; // Usuario o contraseña incorrectos
    } catch (err) {
      print("DEBUG: Error al logearse => $err");
      return {};
    }
  }
}
