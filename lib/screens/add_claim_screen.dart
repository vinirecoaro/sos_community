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
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController cepController = TextEditingController();
    final TextEditingController numController = TextEditingController();

    view = claim.edit;

    if (view) {
      titleController.text = claim.title;
      descriptionController.text = claim.description;
    }

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
                    InputField(
                      label: "Título",
                      controller: titleController,
                    ),
                    InputFieldLarge(
                      label: "Descrição",
                      controller: descriptionController,
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
                      Column(
                        children: [
                          InputField(
                            label: "CEP",
                            controller: cepController,
                          ),
                          InputField(
                            label: "Número",
                            controller: numController,
                          ),
                        ],
                      ),
                    FilledButton(
                      onPressed: () {
                        print(
                            "${titleController.text}, ${descriptionController.text}, ${cepController.text}, ${numController.text}");
                      },
                      child: const Text("Enviar"),
                    ),
                  ],
                ),
              if (view)
                Column(
                  children: [
                    InputField(
                      label: "Título",
                      enabled: false,
                      controller: titleController,
                    ),
                    InputFieldLarge(
                      label: "Descrição",
                      enabled: false,
                      controller: descriptionController,
                    ),
                    const PhotoUploadContainer(),
                  ],
                )
            ],
          ),
        ));
  }
}
