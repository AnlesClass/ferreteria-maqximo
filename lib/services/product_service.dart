import 'dart:convert';
import 'dart:io';

import 'package:app_ferreteria/models/producto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseURL;

  ProductService({required this.baseURL});

  void addProduct(Producto producto) async {
    final url = Uri.parse("$baseURL/productos/crud/add");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: productoToJson(producto)
    );
    //TODO: No manejar SnackBar en el Service.
    if (response.statusCode == 202) {
      const SnackBar(content: Text("Producto Agregado Correctamente."));
    } else if (response.statusCode == 500) {
      const SnackBar(content: Text("Error al Agregar Producto."));
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    final url = Uri.parse("$baseURL/upload");

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        print("DEBUG: Imagen subida exitosamente");
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);
        String generatedFilename = jsonResponse['filename'];
        return generatedFilename;
      } else {
        print("DEBUG: Error al subir imagen: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("DEBUG: Excepción: $e");
      return null;
    }
  }

  Future<List<dynamic>> getProductsNames (String name) async {
    final url = Uri.parse("$baseURL/productos/get/names?name=$name");

    try {
      // OBTENER respuesta del servidor (productos)
      final res = await http.get(url);

      // DEVOLVER si existe un error interno del servidor
      if (res.statusCode == 404) return [];

      // CONVERTIR respuesta a un mapa iterable (desde el json)
      final data = jsonDecode(res.body);

      // DEVOLVER lista con mapas 'Nombre'
      return data;
      
    } catch (err) {
      print("Error al consultar nombres de productos: $err");
      return [];
    }
  }

  Future<List<dynamic>> getIdByName(String name) async{
    final url = Uri.parse("$baseURL/productos/get/id?nombre=$name");

    try {
      final res = await http.get(url);

      // DEVOLVER si no se encuentra registro.
      if (res.statusCode == 404) return [];

      return jsonDecode(res.body);
    } catch (err) {
      SnackBar(content: Text("No se pudo obtener Identificador: $err"));
      return [];
    }
  }
}
