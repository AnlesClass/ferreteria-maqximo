// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

Producto productoFromJson(String str) => Producto.fromJson(jsonDecode(str));
String productoToJson(Producto data) => jsonEncode(data.toJson());

class Producto {
  int? idProducto;
  final int idCategoria;
  final String nombre;
  final String descripcion;
  String? path_imagen;

  Producto({
    this.idProducto,
    required this.idCategoria,
    required this.nombre,
    required this.descripcion,
    required this.path_imagen
  });

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
    idProducto: json["idProducto"],
    idCategoria: json["idCategoria"], 
    nombre: json["nombre"],
    descripcion: json["descripcion"],
    path_imagen: json["path_imagen"]
  );

  Map<String, dynamic> toJson() => {
    "idProducto": idProducto,
    "idCategoria": idCategoria,
    "nombre": nombre,
    "descripcion": descripcion,
    "path_imagen": path_imagen
  };
}
