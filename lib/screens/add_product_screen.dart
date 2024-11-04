import 'package:flutter/material.dart';

import 'package:app_ferreteria/themes/themes.dart';
import 'package:app_ferreteria/widgets/widgets.dart';

class AddProductScreen extends StatelessWidget {
   
  const AddProductScreen({super.key});
  
  //TODO: Cambiar por una consulta Json real.
  static Map<int, dynamic> categorias ={
    0 : {
      "value" : "Value01", // Consulta : Nombre Categoria.
      "message" : "Value01" // Consulta : Nombre Categoria.
    },
    1 : {
      "value" : "Value02",
      "message" : "Value02"
    }
  };   

  @override
  Widget build(BuildContext context) {
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
              color: ClassicTheme.primary, // TODO : Color Test
              width: double.maxFinite,
              height: 200, // TODO: Corregir esto
              child: Image.asset("assets/images/logo_maqximo.jpeg"),
            ),
            // CONTENER: Formulario para Registro del Producto.
            Container(
              color: ClassicTheme.primary, // TODO : Color Test
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
                                  onPressed: () {
                                    // Función para subir imagen.
                                  },
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
                              // 1. Buscar Coincidencias de Nombre
                              const CustomTextField(
                                 labelText: "Nombre del Producto",
                                 hintText: "Comprobar Nombre...",
                                 icon: Icons.search_rounded,
                              ),
                              // 2. Categoría
                              Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: CustomDropDownButton(
                                      initValue: "Value01", //TODO: Cargar 
                                      itemsList: [
                                        // TODO: Diseñar construcción eficiente.
                                        // IDEA: Traer con una consulta Valores y Textos de Categoría y construirlos.

                                        // TODO: Documentar con exactitud esto. (01)
                                        ...categorias.entries.map(
                                          (e) {
                                            return DropdownMenuItem<String>(
                                              value: e.value["value"], // Value01  
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: Row(
                                                  children: [
                                                    // 1. Icono de la Fila.
                                                    // iconData != null ? Icon(iconData) : const Icon(null),
                                                    // 2. Sepración entre Widgets.
                                                    const SizedBox(width: 10),
                                                    // 3. Mensajge de la Fila.
                                                    Text(e.value["message"]),
                                                    ],
                                                  ),
                                              ),
                                            );
                                          }
                                        ),


                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Checkbox(
                                      activeColor: ClassicTheme.primary,
                                      hoverColor: const Color(0x50ffaf00),
                                      shape: const CircleBorder(),
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
                              const CustomTextField(
                                hintText: "Describa su producto...",
                                labelText: "Descripción",
                                lines: 4,
                              ),
                              // 4. Botones
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FilledButton(
                                    style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(ClassicTheme.primary)
                                    ),
                                    onPressed: () => {},
                                    child: const Text("Guardar"),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  FilledButton(
                                    style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(ClassicTheme.primary)
                                    ),
                                    onPressed: () => {},
                                    child: const Text("Cancelar")
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