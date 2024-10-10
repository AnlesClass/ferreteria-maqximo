import 'package:flutter/material.dart';

class CustomDropDownButton extends StatefulWidget {

  final List<DropdownMenuItem<dynamic>>? itemsList;
  final String? initValue;

  const CustomDropDownButton({
    super.key,
    required this.initValue,
    required this.itemsList,
  });

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {

  String? currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //CREANDO: Decoración del borde.
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.blueGrey,
          width: 1.5
        )
      ),
      //CREANDO: Desplegable de opciones.
      child: DropdownButton(
        //ADAPTANDO: Forma de los bordes al abrir la lista.
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        elevation: 2,
        isExpanded: true,
        underline: const SizedBox(), //BORRANDO: La (molesta) línea bajo el desplegable. 
        value: currentValue,
        items: widget.itemsList,
        onChanged: (value) => {
          //ACTUAILIZANDo: Valor que se muestra seleccionado.
          setState(() {
            currentValue = value;
          })
        },
      ),
    );
  }
}
