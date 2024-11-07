import 'dart:io';
import 'package:app_ferreteria/models/producto.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ProductService {

  final String baseURL;

  ProductService({required this.baseURL});

  void addProduct(Producto producto) async {
    final url = Uri.parse('$baseURL/product/crud/add');

    final response = await http.post(
      url,
      headers: {
        "Contetnt-Type" : "applicacation/json"
      },
      body: {
        "idCategoria": producto.idCategoria,
        "nombre": producto.nombre,
        "descripcion": producto.descripcion,
        "path_imagen": producto.path_imagen
      }
    );

    if (response.statusCode == 202){
      print("DEBUG: Producto Agregado");
    } else if (response.statusCode == 500) {
      print("DEBUG: Error al Agregar Producto");
    }
  }

  Future<void> uploadImage(File imageFile) async {
  final url = Uri.parse("http://localhost:3000/upload"); // Cambia la URL según tu servidor.

  try {
    var request = http.MultipartRequest('POST', url);
    request.files.add(
      await http.MultipartFile.fromPath(
        'image', // Nombre del campo esperado en el servidor.
        imageFile.path,
        filename: basename(imageFile.path), // Nombre de archivo opcional.
      ),
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Imagen subida exitosamente");
    } else {
      print("Error al subir imagen: ${response.statusCode}");
    }
  } catch (e) {
    print("Excepción: $e");
  }
}
}