import 'dart:convert';

Existencia existenciaFromJson(String str) => Existencia.fromJson(jsonDecode(str));
String existenciaToJson(Existencia data) => jsonEncode(data.toJson());

class Existencia {
  int? idExistencia;
  final int idProducto;
  final int idSede;
  final int cantidad;
  final double precio;
  final String fecha_registro;

  Existencia({
    this.idExistencia,
    required this.idProducto,
    required this.idSede,
    required this.cantidad,
    required this.precio,
    required this.fecha_registro
  });

  factory Existencia.fromJson(Map<String, dynamic> json) => Existencia(
    idExistencia: json["idExistencia"],
    idProducto: json["idProducto"],
    idSede: json["idSede"],
    cantidad: json["cantidad"],
    precio: json["precio"],
    fecha_registro: json["fecha_registro"]
  );

  Map<String, dynamic> toJson() => {
    "idExistencia": idExistencia,
    "idProducto": idProducto,
    "idSede": idSede,
    "cantidad": cantidad,
    "precio": precio,
    "fecha_registro": fecha_registro
  };
}