import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String hint;
  final IconData? icone;

  Editor(this.controlador, this.rotulo, this.hint, [this.icone]);

  @override
  Widget build(BuildContext context) {
    final roxoPrincipal = Colors.deepPurple.shade400;
    final roxoSuave = Colors.deepPurple.shade100;
    final roxoClaro = Colors.deepPurple.shade50;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
        controller: controlador,
        style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
        decoration: InputDecoration(
          filled: true,
          fillColor: roxoClaro,

          icon: icone != null ? Icon(icone, color: roxoPrincipal) : null,

          labelText: rotulo,
          labelStyle: TextStyle(color: roxoPrincipal),

          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500]),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: roxoSuave, width: 1.5),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: roxoPrincipal, width: 2),
          ),
        ),
      ),
    );
  }
}
