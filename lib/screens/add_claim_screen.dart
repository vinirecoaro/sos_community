import 'package:flutter/material.dart';
import 'package:sos_community/components/input_field.dart';
import 'package:sos_community/components/input_field_large.dart';
import 'package:sos_community/components/photo_upload_container.dart';
import 'package:sos_community/models/claim.dart';

class AddClaimScreen extends StatefulWidget {
  const AddClaimScreen({super.key});

  @override
  State<AddClaimScreen> createState() => _AddClaimScreenState();
}

class _AddClaimScreenState extends State<AddClaimScreen> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    bool view;
    final Claim claim = ModalRoute.of(context)!.settings.arguments as Claim;

    view = claim.edit;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Adicionar Reclamação'),
          actions: [
            if (view)
              IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (!view)
                Column(
                  children: [
                    const InputField(
                      label: "Título",
                    ),
                    const InputFieldLarge(
                      label: "Descrição",
                    ),
                    const PhotoUploadContainer(),
                    Row(
                      children: [
                        Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            }),
                        const Text("Usar minha localização")
                      ],
                    ),
                    if (!isChecked)
                      const Column(
                        children: [
                          InputField(
                            label: "CEP",
                          ),
                          InputField(
                            label: "Número",
                          ),
                        ],
                      ),
                    const FilledButton(
                      onPressed: null,
                      child: Text("Enviar"),
                    ),
                  ],
                ),
              if (view)
                Column(
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
                    const PhotoUploadContainer(),
                  ],
                )
            ],
          ),
        ));
  }
}
