import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(jsonDecode(str));
String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
  int? idCliente;
  final String dni;
  final String nombre;
  final String apellido;
  final String telefono;

  Cliente({
    this.idCliente,  
    required this.dni,
    required this.nombre,
    required this.apellido,
    required this.telefono
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
    idCliente: json["idCliente"],
    dni: json["dni"],
    nombre: json["nombre"],
    apellido: json["apellido"],
    telefono: json["telefono"]
  );

  Map<String, dynamic> toJson() => {
    "idCliente": idCliente,
    "dni": dni,
    "nombre": nombre,
    "apellido": apellido,
    "telefono": telefono
  };
}