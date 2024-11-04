import 'dart:convert';

Categoria categoriaFromJson(String str) => Categoria.fromJson(jsonDecode(str));
String categoriaToJson(Categoria data) => jsonEncode(data.toJson());

class Categoria {
  int? idCategoria;
  final String nombre;

  Categoria({
    this.idCategoria,
    required this.nombre
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
    idCategoria: json["idCategoria"],
    nombre: json["nombre"]
  );

  Map<String, dynamic> toJson() => {
    "idCategoria": idCategoria,
    "nombre": nombre
  };
}