import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sos_community/components/input_field.dart';
import 'package:sos_community/components/input_field_large.dart';
import 'package:sos_community/components/photo_upload_container.dart';
import 'package:sos_community/models/claim.dart';
import 'package:sos_community/providers/claim_provider.dart';
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
  bool fetchingLocation = true;

  @override
  Widget build(BuildContext context) {
    bool view;
    final Claim editClaim = ModalRoute.of(context)!.settings.arguments as Claim;
    final claimProvider = context.watch<ClaimProvider>();

    view = editClaim.edit;

    if (view) {
      titleController.text = editClaim.title;
      descriptionController.text = editClaim.description;
      if (editClaim.lat == null) {
        isChecked = false;
        cepController.text = editClaim.cep.toString();
        numController.text = editClaim.num.toString();
      } else {
        latController.text = editClaim.lat.toString();
        lonController.text = editClaim.lon.toString();
      }
    }

    if (!view && isChecked) {
      if (latController.text.isEmpty || lonController.text.isEmpty) {
        LocationService.determinePosition().then((value) {
          latController.text = value.latitude.toString();
          lonController.text = value.longitude.toString();
          setState(() {
            fetchingLocation = false;
            buttonEnabled = true;
          });
        });
      }
    }

    if (!isChecked) {
      setState(() {
        fetchingLocation = false;
        buttonEnabled = true;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Adicionar Reclamação'),
          actions: [
            if (view)
              IconButton(
                  onPressed: () {
                    showAlertDialog(context, claimProvider, editClaim);
                  },
                  icon: const Icon(Icons.delete))
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
                    if (fetchingLocation)
                      const Column(
                        children: [
                          Text("Buscando localização"),
                          SizedBox(
                            height: 10,
                          )
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
                                } else {
                                  claimProvider.insert(
                                    Claim(
                                        lat: double.parse(
                                            latController.text.toString()),
                                        lon: double.parse(
                                            lonController.text.toString()),
                                        description: descriptionController.text,
                                        title: titleController.text,
                                        date: DateTime.now()),
                                  );
                                  Navigator.pop(context);
                                }
                              } else {
                                if (titleController.text.isEmpty ||
                                    descriptionController.text.isEmpty ||
                                    cepController.text.isEmpty ||
                                    numController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Preencher todos os campos")));
                                } else {
                                  claimProvider.insert(
                                    Claim(
                                        cep: int.parse(
                                            cepController.text.toString()),
                                        num: int.parse(
                                            numController.text.toString()),
                                        description: descriptionController.text,
                                        title: titleController.text,
                                        date: DateTime.now()),
                                  );
                                  Navigator.pop(context);
                                }
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

  void showAlertDialog(
      BuildContext context, ClaimProvider claimProvider, Claim claim) {
    // Button configuration
    Widget okButton = TextButton(
      child: const Text("Apagar"),
      onPressed: () {
        claimProvider.delete(claim);
        Navigator.of(context).pop(); // Close dialog
        Navigator.pop(context);
      },
    );

    //  AlertDialog configuration
    AlertDialog alert = AlertDialog(
      title: const Text("Excluir reclamação"),
      content: const Text("Prosseguir com a exclusão dessa reclamação?"),
      actions: [
        okButton,
      ],
    );

    // show dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
