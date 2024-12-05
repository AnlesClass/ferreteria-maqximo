import 'package:flutter/material.dart';

import '../view_models/view_models.dart';
import '../widgets/widgets.dart';
import '../services/services.dart';

import 'package:provider/provider.dart';

class ReadExistenceScreen extends StatelessWidget {

  const ReadExistenceScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final debouncer = Debouncer(miliseconds: 1500);
    final readExistenceViewmodel = Provider.of<ReadExistenceViewModel>(context);
    final loginData = Provider.of<LoginDataService>(context);

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
                  "Filtrado de Existencias",
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // ----- FILTRAR POR NOMBRE -----
                CustomTextField(
                  controller: readExistenceViewmodel.nombreExistencia,
                  hintText: "Buscar la Existencia...",
                  labelText: "Búsqueda",
                  icon: Icons.manage_search_rounded,
                  onChanged: (value) {
                    debouncer.execute(() {
                      readExistenceViewmodel.getExistences(loginData.idSede, value);
                    });
                  },
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