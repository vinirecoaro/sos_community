import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sos_community/components/input_field.dart';
import 'package:sos_community/components/input_field_large.dart';
import 'package:sos_community/components/photo_container.dart';
import 'package:sos_community/components/photo_upload_container.dart';
import 'package:sos_community/models/claim.dart';
import 'package:sos_community/providers/claim_provider.dart';
import 'package:sos_community/service/location_service.dart';
import 'package:sos_community/util/keys.dart';
import 'package:weather_data_pk/weather_data_pk.dart';

class AddClaimScreen extends StatefulWidget {
  const AddClaimScreen({super.key});

  @override
  State<AddClaimScreen> createState() => _AddClaimScreenState();
}

class _AddClaimScreenState extends State<AddClaimScreen> {
  bool getLocation = true;
  bool fetchingLocationText = true;
  bool sendButtonEnabled = false;
  bool getWeather = false;
  double? weatherTemp;
  String? weatherDescription;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController lonController = TextEditingController();
  final TextEditingController weatherTempController = TextEditingController();
  final TextEditingController weatherDescriptionController =
      TextEditingController();
  List<String> _capturedImagesPath = [];

  @override
  Widget build(BuildContext context) {
    bool edit;
    final Claim editClaim = ModalRoute.of(context)!.settings.arguments as Claim;
    final claimProvider = context.watch<ClaimProvider>();

    void updateImages(List<String> images) {
      setState(() {
        _capturedImagesPath = images;
      });
    }

    edit = editClaim.edit;

    if (edit) {
      titleController.text = editClaim.title;
      descriptionController.text = editClaim.description;
      if (editClaim.lat == null) {
        getLocation = false;
        cepController.text = editClaim.cep.toString();
        numController.text = editClaim.num.toString();
      } else {
        latController.text = editClaim.lat.toString();
        lonController.text = editClaim.lon.toString();
      }
      if (editClaim.weatherTemp != null &&
          editClaim.weatherDescription != null) {
        weatherTempController.text =
            "${editClaim.weatherTemp!.toStringAsFixed(1)}°C";
        weatherDescriptionController.text =
            editClaim.weatherDescription.toString();
        getWeather = true;
      }
    }

    if (!edit && getLocation) {
      if (latController.text.isEmpty || lonController.text.isEmpty) {
        LocationService.determinePosition().then((value) {
          latController.text = value.latitude.toString();
          lonController.text = value.longitude.toString();
          setState(() {
            fetchingLocationText = false;
            sendButtonEnabled = true;
          });
        });
      }
    }

    if (!getLocation) {
      setState(() {
        fetchingLocationText = false;
        sendButtonEnabled = true;
      });
    }

    if (getWeather && weatherTemp == null) {
      setState(() {
        sendButtonEnabled = false;
      });
      var lat = double.parse(latController.text.toString());
      var lon = double.parse(lonController.text.toString());
      WeatherDataService.getWeather(
        Keys.API_KEY,
        lat,
        lon,
      ).then((value) {
        weatherTemp = value.main!.temp! - 273;
        weatherDescription = value.weather![0].description;
        setState(() {
          sendButtonEnabled = true;
        });
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Adicionar Reclamação'),
          actions: [
            if (edit)
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
              if (!edit)
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
                    PhotoUploadContainer(
                      onImagesChanged: updateImages,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: getLocation,
                            onChanged: (value) {
                              setState(() {
                                getLocation = value!;
                              });
                            }),
                        const Text("Usar minha localização")
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: getWeather,
                            onChanged: (value) {
                              setState(() {
                                if (getLocation &&
                                    !getWeather &&
                                    sendButtonEnabled) {
                                  getWeather = value!;
                                } else if (!getLocation && !getWeather) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Necessário usar localização atual")));
                                } else if (getWeather) {
                                  getWeather = value!;
                                }
                              });
                            }),
                        const Text("Incluir informações do clima no local")
                      ],
                    ),
                    if (fetchingLocationText)
                      const Column(
                        children: [
                          Text("Buscando localização"),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    if (!getLocation)
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
                      onPressed: sendButtonEnabled
                          ? () {
                              if (getLocation && !getWeather) {
                                if (titleController.text.isEmpty ||
                                    descriptionController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Preencher todos os campos")));
                                } else {
                                  if (_capturedImagesPath.isEmpty) {
                                    claimProvider.insert(
                                      Claim(
                                        lat: double.parse(
                                            latController.text.toString()),
                                        lon: double.parse(
                                            lonController.text.toString()),
                                        description: descriptionController.text,
                                        title: titleController.text,
                                        date: DateTime.now(),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    claimProvider.insert(
                                      Claim(
                                          lat: double.parse(
                                              latController.text.toString()),
                                          lon: double.parse(
                                              lonController.text.toString()),
                                          description:
                                              descriptionController.text,
                                          title: titleController.text,
                                          date: DateTime.now(),
                                          picturesPath: _capturedImagesPath),
                                    );
                                    Navigator.pop(context);
                                  }
                                }
                              } else if (getLocation && getWeather) {
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
                                        date: DateTime.now(),
                                        weatherTemp: weatherTemp,
                                        weatherDescription: weatherDescription),
                                  );
                                  Navigator.pop(context);
                                }
                              } else if (!getLocation && getWeather) {
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
                                        date: DateTime.now(),
                                        weatherTemp: weatherTemp,
                                        weatherDescription: weatherDescription),
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
                                      date: DateTime.now(),
                                    ),
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
              if (edit)
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
                    if (editClaim.picturesPath != null)
                      PhotoContainer(imagesPath: editClaim.picturesPath!),
                    if (!getLocation)
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
                    if (getLocation)
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
                      ),
                    if (getWeather)
                      Column(
                        children: [
                          InputField(
                            label: "Temperatura",
                            enabled: false,
                            controller: weatherTempController,
                          ),
                          InputField(
                            label: "Clima",
                            enabled: false,
                            controller: weatherDescriptionController,
                          ),
                        ],
                      ),
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
