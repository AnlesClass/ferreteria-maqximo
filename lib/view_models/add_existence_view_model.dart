import 'package:flutter/material.dart';

import '../services/services.dart';
import '../models/models.dart';

class AddExistenceViewModel extends ChangeNotifier{
  final TextEditingController nombreProductoController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  List<String> productosNombres = [];
  List<dynamic> sedesNombres = [];
  int initialSede = -1;
  int idProducto = -1;
  String productSelected = "";
  final ExistenciaService _existenciaService;
  final ProductService _productService;
  final SedeService _sedeService;

  AddExistenceViewModel(this._productService, this._sedeService, this._existenciaService) {
    getProductsName("");
    getSedesName();
  }

  Future<bool> registrarExistencia() async {
    if (validar()){
      Existencia existencia = Existencia(
        idProducto: idProducto, 
        idSede: initialSede, 
        cantidad: int.parse(cantidadController.text), 
        precio: double.parse(precioController.text), 
        fecha_registro: DateTime.now().toString()
      );
      return await _existenciaService.addExistence(existencia);
    } else {
      return false;
    }
  }

  Future<void> getProductsName(String? name) async{
    //VACIAR antes de rellenar
    productosNombres.clear();

    //INICIALIZAR variable temporal de productos.
    final productos = await _productService.getProductsNames(name!);

    //DEVOLVER si está vacía la lista con nombre de productos.
    if (productos.isEmpty) productosNombres.clear();

    //LLENAR la lista y notificar actualización
    for (var product in productos){
      productosNombres.add(product["NOMBRE"]);
    }

    notifyListeners();
  }

  Future<void> getSedesName() async{
    //INICIALIZAR variable de sedes.
    List<dynamic> sedes = await _sedeService.getSedes();
    
    //RETORNAR si su contenido es nulo.
    if (sedes.isEmpty) return;

    //DEVOLVER lista de sedes.
    for (var sede in sedes){
      sedesNombres.add([
        sede["IDSEDE"],
        sede["NOMBRE"]
      ]);
    }

    //CONFIGURAR valor de sede inicial.
    initialSede = sedesNombres[0][0];

    notifyListeners();
  }

  Future<void> updateIdProduct(String productName) async{
    final product = await _productService.getIdByName(productName);
    // OBTENER el identificador del producto pulsado.
    idProducto = product[0]["IDPRODUCTO"];
  }

  Future<void> readProduct(String productName, int idSede) async{
    List<dynamic> detalle = await _existenciaService.getExistenceDetails(productName, idSede);

    //COLOCAR en caso no se encuentren coincidencias.
    if (detalle.isEmpty){
      cantidadController.text = 0.toString();
      precioController.text = 0.toString();
      notifyListeners();
      return;
    }

    //CORREGIR los 2 decimales luego del punto.
    double precio = detalle[0]["PRECIO"];

    //COLOCAR si se encontró algo en la BD.
    cantidadController.text = detalle[0]["CANTIDAD"].toString();
    precioController.text = precio.toStringAsFixed(2);

    notifyListeners();
  }

  bool validar(){
    if (idProducto == -1) return false;
    if (cantidadController.text.isEmpty) return false;
    if (precioController.text.isEmpty) return false;
    return true;
  }
  
  void setInitialSede(int initialSede){
    this.initialSede = initialSede;
    notifyListeners();
  }

  void setProductSelected(String productSelected){
    this.productSelected = productSelected;
    notifyListeners();
  }

  void setIdProducto(int idProducto){
    this.idProducto = idProducto;
  }
}