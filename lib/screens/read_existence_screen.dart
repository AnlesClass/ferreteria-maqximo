import 'package:flutter/material.dart';

import 'package:app_ferreteria/themes/themes.dart';

import 'package:app_ferreteria/widgets/widgets.dart';

class ReadExistenceScreen extends StatelessWidget {
   
  const ReadExistenceScreen({super.key});
  

  //TODO: Cambiar por una consulta Json real.
  static Map<int, dynamic> categorias ={
    0 : {
      "value" : "Value01", // Consulta : Nombre Categoria.
      "message" : "Por Precio" // Consulta : Nombre Categoria.
    },
    1 : {
      "value" : "Value02",
      "message" : "Por Stock"
    }
  };   


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Icon(
          Icons.bolt_rounded,
          color: Colors.white,
          size: 30,
        ),
        backgroundColor: ClassicTheme.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                const Text(
                  "Tipo de Filtrado",
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomDropDownButton(
                  initValue: "Value01",
                  itemsList: [
                    // TODO: Documentar con exactitud esto.
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
                  ]
                ),
                const SizedBox(
                  height: 15,
                ),
                const CustomTextField(
                  hintText: "Buscar la Existencia...",
                  labelText: "Búsqueda",
                  icon: Icons.manage_search_rounded,
                ),
                const SizedBox(
                  height: 10,
                  child: Divider(
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Test-Top",
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    "Test-Bottom",
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              )
                            ),
                            Expanded(
                              child: Text(
                                "Test-Right",
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}