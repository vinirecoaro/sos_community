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
      body: !view
          ? const SingleChildScrollView(
              child: Column(
                children: [
                  InputField(
                    label: "Título",
                  ),
                  InputFieldLarge(
                    label: "Descrição",
                  ),
                  InputField(
                    label: "CEP",
                  ),
                  InputField(
                    label: "Número",
                  ),
                  FilledButton(
                    onPressed: null,
                    child: Text("Enviar"),
                  )
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  InputField(
                    label: "Título",
                    enabled: false,
                    initialText: claim.title,
                  ),
                  InputFieldLarge(
                    label: "Descrição",
                    enabled: false,
                    initialText: claim.description,
                  ),
                  const InputField(
                    label: "CEP",
                    enabled: false,
                  ),
                  const InputField(
                    label: "Número",
                    enabled: false,
                  ),
                ],
              ),
            ),
    );
  }
}
