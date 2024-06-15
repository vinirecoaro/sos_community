import 'package:flutter/material.dart';
import 'package:sos_community/components/input_field.dart';
import 'package:sos_community/components/input_field_large.dart';
import 'package:sos_community/components/photo_upload_container.dart';
import 'package:sos_community/models/claim.dart';
import 'package:sos_community/service/location_service.dart';

class AddClaimScreen extends StatefulWidget {
  const AddClaimScreen({super.key});

  @override
  State<AddClaimScreen> createState() => _AddClaimScreenState();
}

class _AddClaimScreenState extends State<AddClaimScreen> {
  bool isChecked = true;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController lonController = TextEditingController();
  bool buttonEnabled = false;

  @override
  Widget build(BuildContext context) {
    bool view;
    final Claim claim = ModalRoute.of(context)!.settings.arguments as Claim;

    view = claim.edit;

    if (view) {
      titleController.text = claim.title;
      descriptionController.text = claim.description;
      if (claim.lat == null) {
        isChecked = false;
        cepController.text = claim.cep.toString();
        numController.text = claim.num.toString();
      } else {
        latController.text = claim.lat.toString();
        lonController.text = claim.lon.toString();
      }
    }

    if (!view && isChecked) {
      if (latController.text.isEmpty || lonController.text.isEmpty) {
        LocationService.determinePosition().then((value) {
          latController.text = value.latitude.toString();
          lonController.text = value.longitude.toString();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Buscando localização")));
          setState(() {
            buttonEnabled = true;
          });
        });
      }
    }

    if (!isChecked) {
      setState(() {
        buttonEnabled = true;
      });
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
                      onPressed: buttonEnabled
                          ? () {
                              if (isChecked) {
                                if (titleController.text.isEmpty ||
                                    descriptionController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Preencher todos os campos")));
                                } else {}
                              } else {
                                if (titleController.text.isEmpty ||
                                    descriptionController.text.isEmpty ||
                                    cepController.text.isEmpty ||
                                    numController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Preencher todos os campos")));
                                } else {}
                              }
                            }
                          : null,
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
                    if (!isChecked)
                      Column(
                        children: [
                          InputField(
                            label: "CEP",
                            enabled: false,
                            controller: cepController,
                          ),
                          InputField(
                            label: "Número",
                            enabled: false,
                            controller: numController,
                          ),
                        ],
                      ),
                    if (isChecked)
                      Column(
                        children: [
                          InputField(
                            label: "Latidude",
                            enabled: false,
                            controller: latController,
                          ),
                          InputField(
                            label: "Longitude",
                            enabled: false,
                            controller: lonController,
                          ),
                        ],
                      )
                  ],
                )
            ],
          ),
        ));
  }
}
