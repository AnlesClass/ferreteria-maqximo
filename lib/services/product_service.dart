import 'dart:convert';
import 'dart:io';

import 'package:app_ferreteria/models/producto.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseURL;

  ProductService({required this.baseURL});

  void addProduct(Producto producto) async {
    final url = Uri.parse("$baseURL/productos/crud/add");

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: productoToJson(producto));

    if (response.statusCode == 202) {
      print("DEBUG: Producto Agregado");
    } else if (response.statusCode == 500) {
      print("DEBUG: Error al Agregar Producto");
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
}
