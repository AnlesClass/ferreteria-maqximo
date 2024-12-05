import 'package:app_ferreteria/view_models/read_existence_view_model.dart';
import 'package:flutter/material.dart';

import 'package:app_ferreteria/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ReadExistenceScreen extends StatelessWidget {

  const ReadExistenceScreen({super.key});

  static Map<int, dynamic> categorias ={
    0 : {
      "value" : "Value01",
      "message" : "Por Precio"
    },
    1 : {
      "value" : "Value02",
      "message" : "Por Stock"
    }
  };

  @override
  Widget build(BuildContext context) {

    final readExistenceViewmodel = Provider.of<ReadExistenceViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Icon(
          Icons.bolt_rounded,
          color: Colors.white,
          size: 30,
        ),
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
                CustomTextField(
                  controller: readExistenceViewmodel.nombreExistencia,
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
          // ----- VISUALIZAR EXISTENCIAS -----
          Expanded(
            child: ListView(
              children: readExistenceViewmodel.existences.map((existence){
                return ListTile(
                  title: Text(existence["NOMBRE"]),
                  subtitle: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(existence["FECHA_REGISTRO"]),
                      Text(existence["PRECIO"].toString())
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      )
    );
  }
}