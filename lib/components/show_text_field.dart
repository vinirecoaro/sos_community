import 'package:flutter/material.dart';

class ShowTextField extends StatelessWidget {
  const ShowTextField({
    super.key,
    this.label = "label name",
    this.enabled = true,
    this.controller,
  });

  final String label;
  final bool enabled;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black, // Cor do rótulo fixa
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey, // Cor fixa da borda
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey, // Cor fixa da borda quando habilitado
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.indigo, // Cor fixa da borda quando focado
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey, // Cor fixa da borda quando desabilitado
              width: 1.5,
            ),
          ),
        ),
        style: const TextStyle(
          color: Colors.black, // Cor fixa do texto
        ),
      ),
    );
  }
}
