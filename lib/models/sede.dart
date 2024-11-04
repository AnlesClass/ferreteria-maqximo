import 'dart:convert';

Sede sedeFromJson(String str) => Sede.fromJson(jsonDecode(str));
String sedeToJson(Sede data) => jsonEncode(data.toJson());

class Sede{
  int? idSede;
  final String nombre;

  Sede({
    this.idSede,
    required this.nombre
  });

  factory Sede.fromJson(Map<String, dynamic> json) => Sede(
    idSede: json["idSede"],
    nombre: json["nombre"]
  );

  Map<String, dynamic> toJson() => {
    "idSede": idSede,
    "nombre": nombre
  };
}