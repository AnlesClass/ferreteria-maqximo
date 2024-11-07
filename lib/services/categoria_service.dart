import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoriaService {

  final String baseUrl;

  CategoriaService({
    required this.baseUrl
  });
  
  //DEVUELVE una lista con 'Objetos' de tipo 'Categoria'
  Future<List<dynamic>> getCategoriasList() async{
    final url = Uri.parse('$baseUrl/categorias/get/all');

    try {
      //TRAER json en crudo.
      final response = await http.get(url);

      //DEVOLVER nulo si la petición arrojó un error.
      if (response.statusCode == 500) return [];
      
      //CONVERTIR el cuerpo del Json en una lista (para iterar).
      final List<dynamic> data = jsonDecode(response.body);

      //RETORNA una lista con todos los Json de Categoría.
      return data;
    } catch (e) {
      print('ERROR: En Categoria_Service: $e');
      return [];
    }
  }
}