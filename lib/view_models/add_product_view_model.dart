import 'dart:io';

import 'package:app_ferreteria/services/categoria_service.dart';
import 'package:app_ferreteria/services/product_service.dart';
import 'package:app_ferreteria/view_models/form_view_model_base.dart';
import 'package:flutter/material.dart';
import '../models/producto.dart';

class AddProductViewModel extends FormViewModelBase{

  File? imageProduct;
  final CategoriaService _categoriaService;
  final ProductService _productService;
  final TextEditingController nombreProducto = TextEditingController();
  final TextEditingController descripcionProducto = TextEditingController();
  String categoriaInitValue = '1';
  List<DropdownMenuItem<String>> categoriasOptions = [];

  AddProductViewModel(this._categoriaService, this._productService) {
    updateCategoriaItems();
  }

  //OBTENER lista de Widgets => DropdownMenuItem
  Future<void> updateCategoriaItems() async {
  
    //OBTENER una lista con categorias (Iterable)
    List<dynamic> data = await _categoriaService.getCategoriasList();
    List<DropdownMenuItem<String>> items = [];

    //ITERAR para agregar <DropdownMenuItem<String>> al Array.
    for (var categoria in data) {
      items.add(
        DropdownMenuItem(
          value: categoria['IDCATEGORIA'].toString(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(categoria['NOMBRE']),
          ),
        ));
    }

    //ACTUALIZAR nuestras opciones.
    categoriasOptions = items;
    notifyListeners();
  }

  //ACTUALIZAR el valor del 'DropdownMenu'
  void setCategoriaDropdown(newValue){
    categoriaInitValue = newValue;
    notifyListeners();
  }

  //ACTUALIZAR imagen.
  void setImage(File? image) {
    imageProduct = image;
    notifyListeners();
  }

  //SUBIR producto al servidor.
  bool uploadProduct(Producto product, File imagen){
    try {
      // AGREGAR imagen a la Base de Datos y CAPTURAR nombre para la ruta del producto.
      _productService.uploadImage(imagen).then((value){
        product.path_imagen = 'images/$value';

        // SUBIR producto a la Base de Datos.
        _productService.addProduct(product);
      });
    } catch (e) {
      print("DEBUG: $e");
      return false;
    }
    return true;
  }
}