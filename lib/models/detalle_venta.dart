import 'dart:ffi';



class DetalleVenta {
  int? idDetalleVenta;
  final int idExistencia;
  final int idVenta;
  final int cantidadVenta;
  final Float precioVenta;

  DetalleVenta({
    this.idDetalleVenta,
    required this.idExistencia,
    required this.idVenta,
    required this.cantidadVenta,
    required this.precioVenta
  });

  factory DetalleVenta.fromJson(Map<String, dynamic> json) => DetalleVenta(
    idDetalleVenta: json["idDetalleVenta"],
    idExistencia: json["idExistencia"],
    idVenta: json["idVenta"],
    cantidadVenta: json["cantidadVenta"],
    precioVenta: json["precioVenta"]
  );

  Map<String, dynamic> toJson() => {
    "idDetalleVenta": idDetalleVenta,
    "idExistencia": idExistencia,
    "idVenta": idVenta,
    "cantidadVenta": cantidadVenta,
    "precioVenta": precioVenta
  };
}