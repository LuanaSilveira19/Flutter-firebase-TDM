import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String hint;
  final IconData? icone;

  const Editor(this.controlador, this.rotulo, this.hint, [this.icone]);

  @override
  Widget build(BuildContext context) {
    const tealPrincipal = Color(0xFF00897B); // teal 600
    const tealSuave = Color(0xFFB2DFDB); // teal 100
    const fundo = Color(0xFFF5F5F5); // neutro claro

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        controller: controlador,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },

        style: const TextStyle(fontSize: 16, color: Colors.black87),

        decoration: InputDecoration(
          filled: true,
          fillColor: fundo,

          prefixIcon: icone != null ? Icon(icone, color: tealPrincipal) : null,

          labelText: rotulo,
          labelStyle: const TextStyle(color: tealPrincipal),

          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade500),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: tealSuave, width: 1.5),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: tealPrincipal, width: 2),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}
