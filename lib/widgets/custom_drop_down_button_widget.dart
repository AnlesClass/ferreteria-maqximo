import 'package:flutter/material.dart';

class CustomDropDownButton extends StatefulWidget {
  final List<DropdownMenuItem<dynamic>>? itemsList;
  final dynamic initValue;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? sizeBorder;
  final void Function(dynamic)? onChange;
  final IconData? iconData;

  const CustomDropDownButton({
    super.key,
    required this.initValue,
    required this.itemsList,
    this.backgroundColor,
    this.borderColor,
    this.sizeBorder,
    this.onChange,
    this.iconData
  });

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //CREANDO: Decoración del borde.
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.transparent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: widget.borderColor ?? Colors.blueGrey,
              width: widget.sizeBorder ?? 1.5)),
      //CREANDO: Desplegable de opciones.
      child: DropdownButton(
        //ADAPTANDO: Forma de los bordes al abrir la lista.
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        elevation: 2,
        isExpanded: true,
        icon: (widget.iconData != null) ? Padding(padding: const EdgeInsets.symmetric(horizontal: 12.5), child: Icon(widget.iconData)) : null,
        underline: const SizedBox(), //BORRANDO: La (molesta) línea bajo el desplegable.
        value: widget.initValue,
        items: widget.itemsList,
        focusColor: widget.backgroundColor ?? Colors.transparent,
        onChanged: widget.onChange
      ),
    );
  }
}
