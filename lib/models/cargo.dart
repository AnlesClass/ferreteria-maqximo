import 'dart:convert';

Cargo cargoFromJson(String str) => Cargo.fromJson(jsonDecode(str));
String cargoToJson(Cargo data) => json.encode(data.toJson());

class Cargo{
  final int idCargo;
  final String nombre;

  Cargo({
    required this.idCargo,
    required this.nombre
  });

  factory Cargo.fromJson(Map<String, dynamic> json) => Cargo(
    idCargo: json["idCargo"],
    nombre: json["nombre"]
  );

  Map<String, dynamic> toJson() => {
    "idCargo": idCargo,
    "nombre": nombre
  };
}