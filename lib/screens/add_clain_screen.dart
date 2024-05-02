import 'package:flutter/material.dart';
import 'package:sos_community/components/input_field.dart';
import 'package:sos_community/components/input_field_large.dart';

class AddClaimScreen extends StatefulWidget {
  const AddClaimScreen({super.key});

  @override
  State<AddClaimScreen> createState() => _AddClaimScreenState();
}

class _AddClaimScreenState extends State<AddClaimScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Reclamação'),
      ),
      body: Column(
        children: [
          const InputField(
            label: "Título",
          ),
          InputFieldLarge(
            label: "Descrição",
          ),
          const InputField(
            label: "CEP",
          ),
          const InputField(
            label: "Número",
          ),
          const FilledButton(
            onPressed: null,
            child: Text("Enviar"),
          )
        ],
      ),
    );
  }
}
