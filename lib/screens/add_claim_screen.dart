import 'package:flutter/material.dart';
import 'package:sos_community/components/input_field.dart';
import 'package:sos_community/components/input_field_large.dart';
import 'package:sos_community/models/claim.dart';

class AddClaimScreen extends StatefulWidget {
  const AddClaimScreen({super.key});

  @override
  State<AddClaimScreen> createState() => _AddClaimScreenState();
}

class _AddClaimScreenState extends State<AddClaimScreen> {
  @override
  Widget build(BuildContext context) {
    bool view;
    final Claim claim = ModalRoute.of(context)!.settings.arguments as Claim;

    view = claim.edit;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Reclamação'),
        actions: [
          if (view) IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
        ],
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
          if (!view)
            const FilledButton(
              onPressed: null,
              child: Text("Enviar"),
            )
        ],
      ),
    );
  }
}
