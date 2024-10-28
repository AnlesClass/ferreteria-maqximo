import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  final int idCargo;
  final int idSede;
  final String nombre;
  final String apellido;
  final String email;
  final String password;

  User(
      {required this.idCargo,
      required this.idSede,
      required this.nombre,
      required this.apellido,
      required this.email,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) => User(
        idCargo: json["idCargo"],
        idSede: json["idSede"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "idCargo": idCargo,
        "idSede": idSede,
        "nombre": nombre,
        "apellido": apellido,
        "email": email,
        "password": password,
      };
}
