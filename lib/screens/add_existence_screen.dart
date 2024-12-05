import 'package:app_ferreteria/services/services.dart';
import 'package:app_ferreteria/view_models/view_models.dart';
import 'package:app_ferreteria/widgets/widgets.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AddExistenceScreen extends StatelessWidget {

  final Debouncer buscador = Debouncer(miliseconds: 1000);

  AddExistenceScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final addExistenceViewModel = Provider.of<AddExistenceViewModel>(context);
    final loginData = Provider.of<LoginDataService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.5),
          child: Form(
            child: Column(
              children: [
                // ----- SUBTITULO -----
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    children: [
                      Text(
                        "Existencia",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                // ----- BARRA BÚSQUEDA -----
                CustomTextField(
                  controller: addExistenceViewModel.nombreProductoController,
                  keyboardType: TextInputType.text,
                  hintText: "Nombre del Producto a Filtrar",
                  labelText: "Nombre",
                  isAlwaysLabel: true,
                  onChanged: (value) async {
                    buscador.execute(() {
                      addExistenceViewModel.getProductsName(value);
                    },);
                  },
                ),
                // ----- PRODUCTOS -----
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(strokeAlign: 1.0, color: Colors.blueGrey)
                  ),
                  height: 250,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ListView.builder(
                    itemCount: addExistenceViewModel.productosNombres.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(addExistenceViewModel.productosNombres[index]),
                            FilledButton(
                              onPressed: () {
                                //ESCRIBIR el nombre del producto seleccionado.
                                addExistenceViewModel.setProductSelected(addExistenceViewModel.productosNombres[index]);
                                //ACTUALIZAR el identificador del producto
                                addExistenceViewModel.updateIdProduct(addExistenceViewModel.productosNombres[index]);
                                //CONSULTAR información del producto en la base de datos. - Nombre del Producto, Sede en la que estamos (Default: 1)
                                addExistenceViewModel.readProduct(addExistenceViewModel.productosNombres[index], addExistenceViewModel.selectedSede);
                              },
                              child: const Icon(Icons.add_rounded)
                            )
                          ],
                        ),
                      );
                    },
                  )
                ),
                // ----- PRODUCTO SELECCIONADO -----
                Text(
                  (addExistenceViewModel.productSelected == "") 
                  ? "Sin Producto Seleccionado"
                  : "Producto Seleccionado: ${addExistenceViewModel.productSelected}"
                ),
                // ----- SEDE(s) -----
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.5),
                  child: CustomDropDownButton(
                    initValue: addExistenceViewModel.selectedSede,
                    itemsList: addExistenceViewModel.sedesNombres.map((infoSede) {
                      return DropdownMenuItem(
                        value: infoSede[0], // ID de la Sede
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(infoSede[1]), // NOMBRE de la sede
                        ),
                      );
                    }).toList(),
                    onChange: (value) => addExistenceViewModel.setInitialSede(value),
                    iconData: Icons.add_business_rounded,
                  ),
                ),
                // TEXTFIELD: Precio + Cantidad
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomTextField(
                        controller: addExistenceViewModel.cantidadController,
                        labelText: "Cantidad",
                        hintText: "Cantidad del Producto",
                        isAlwaysLabel: true,
                        keyboardType: TextInputType.number,
                        icon: Icons.more
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: CustomTextField(
                        controller: addExistenceViewModel.precioController,
                        labelText: "Precio",
                        hintText: "Precio del Producto",
                        isAlwaysLabel: true,
                        keyboardType: TextInputType.number,
                        icon: Icons.money_rounded
                      ),
                    )
                  ],
                ),
                //BOTONES: Cancelar + Registrar
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (Navigator.canPop(context)){
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () {
                          //TODO: Validar para que si hay una existencia ya registrada entonces se hace un Update.
                          addExistenceViewModel.registrarExistencia().then((value) {
                            if (value){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Existencia Registrada con Éxito."))
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("No se pudo Registrar Existencia."))
                              );
                            }
                          });
                        },
                        child: const Text("Registrar"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}