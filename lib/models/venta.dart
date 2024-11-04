import 'dart:convert';
import 'dart:ffi';

Venta ventaFromJson(String str) => Venta.fromJson(jsonDecode(str));
String ventaToJson(Venta data) => jsonEncode(data.toJson());

class Venta {
  int? idVenta;
  final int idCliente;
  final Float importeTotal;
  final DateTime fecha;

  Venta({
    this.idVenta,
    required this.idCliente,
    required this.importeTotal,
    required this.fecha
  });

  factory Venta.fromJson(Map<String, dynamic> json) => Venta(
    idVenta: json["idVenta"],
    idCliente: json["idCliente"],
    importeTotal: json["importeTotal"],
    fecha: json["fecha"]
  );

  Map<String, dynamic> toJson() => {
    "idVenta": idVenta,
    "idCliente": idCliente,
    "importeTotal": importeTotal,
    "fecha": fecha
  };
}