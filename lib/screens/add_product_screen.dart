import 'dart:io';
import 'package:app_ferreteria/models/producto.dart';
import 'package:flutter/material.dart';

import 'package:app_ferreteria/view_models/add_product_view_model.dart';
import 'package:app_ferreteria/themes/themes.dart';
import 'package:app_ferreteria/widgets/widgets.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatelessWidget {

  File? imageProduct;

  AddProductScreen({super.key});

  //SELECCIONAR imagen de galería y guardarlo en una variable (File)
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imageProduct = File(pickedImage.path);
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final addProductViewmodel = Provider.of<AddProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Producto",
          style: TextStyle(
            fontFamily: 'Caviar_Dreams', // Documentar porque funcionó.
            fontWeight: FontWeight.bold,
            letterSpacing: 2.5
          ),
        ),
        backgroundColor: ClassicTheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CONTENER: Imagen del Logo - (IngCo)
            Container(
              color: ClassicTheme.primary,
              width: double.maxFinite,
              height: 200, // TODO: Corregir esto
              child: Image.asset("assets/images/logo_maqximo.jpeg"),
            ),
            // CONTENER: Formulario para Registro del Producto.
            Container(
              color: ClassicTheme.primary,
              width: double.infinity,
              child: Card(
                // REDONDEAR: Los vértices superiores de la card.
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), 
                    topRight: Radius.circular(20),
                  ),
                ),
                margin: EdgeInsets.zero,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        //DESCRIBIR: Función de esta vista.
                        const ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          title: Text(
                            "Registro de Producto",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20 
                            ),
                          ),
                          subtitle: Text("Subtitulo Corto de Registro de Producto."),
                        ),
                        //SUBIR: Una imagen para el servidor.
                        Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(
                              color: Colors.blueGrey,
                              width: 1.5
                            ),
                          ),
                          child: ListTile(
                            title: const Text(
                              textAlign: TextAlign.center,
                              "Imagen del Producto",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                TextButton(
                                  style: const ButtonStyle(
                                    // El Overlay pinta cuando posiciono el mouse sobre esto.
                                    overlayColor: WidgetStatePropertyAll(Colors.transparent)
                                  ),
                                  onPressed: () => pickImage(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Image.asset(
                                    "assets/images/placeholder_subir_imagen.png",
                                    width: 100,
                                    ),
                                  )
                                ),
                                const Text(
                                  "Insertar una imagen para el producto.",
                                  textAlign: TextAlign.center,  
                                ),
                              ],
                            )
                          ),
                        ),
                        //SEPARADOR
                        const SizedBox(
                          height: 20,
                        ),
                        //CONTENER: Formulario
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                          child: Column(
                            children: [
                              // 1. Asignar Nombre
                              CustomTextField(
                                controller: addProductViewmodel.nombreProducto,
                                labelText: "Nombre del Producto",
                                hintText: "Nombre...",
                                icon: Icons.search_rounded,
                                validator: (value) => addProductViewmodel.validarTexto(value!, "Nombre", minLength: 3, maxLength: 32)
                              ),
                              // 2. Asignar Categoría
                              Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: CustomDropDownButton(
                                      initValue: addProductViewmodel.categoriaInitValue,
                                      itemsList: addProductViewmodel.categoriasOptions,
                                      onChange: (newValue) {
                                        addProductViewmodel.setCategoriaDropdown(newValue);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Checkbox(
                                      value: true,
                                      onChanged: (value) => {},
                                    ),
                                  ),
                                ],
                              ),
                              // 3. Descripción
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                controller: addProductViewmodel.descripcionProducto,
                                hintText: "Describa su producto...",
                                labelText: "Descripción",
                                lines: 4,
                                validator: (value) => addProductViewmodel.validarTexto(value!, "Descripcion")
                              ),
                              // 4. Botones
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FilledButton(
                                    child: const Text("Guardar"),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate() && imageProduct != null){
                                        //OBTENER extensión del archivo.
                                        String extension = imageProduct!.path.split('.').last;
                                        //CREAR producto.
                                        Producto producto = Producto(
                                          idCategoria: int.parse(addProductViewmodel.categoriaInitValue),
                                          nombre: addProductViewmodel.nombreProducto.text,
                                          descripcion: addProductViewmodel.descripcionProducto.text,
                                          //TODO: La linea de abajo funciona en móvil, la otra '.png' es para pruebas en web.
                                          //path_imagen: 'images/${addProductViewmodel.nombreProducto.text}.${extension}'
                                          path_imagen: 'images/${addProductViewmodel.nombreProducto.text}.png'
                                        );
                                        print("DEBUG: ${producto.path_imagen}");
                                        //TODO: Función para subir archivo al servidor con el nombre asignado (nombre del producto).
                                        //addProductViewmodel.uploadProduct(producto, imageProduct);
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  FilledButton(
                                    child: const Text("Cancelar"),
                                    onPressed: () => {}
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                )
              ),
            )
          ],
        ),
      )
    );
  }
}