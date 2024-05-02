import 'package:flutter/material.dart';
import 'package:sos_community/components/input_field.dart';

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
      body: const Column(
        children: [
          InputField(
            label: "Título",
          ),
          InputField(
            label: "CEP",
          ),
          InputField(
            label: "Número",
          ),
        ],
      ),
    );
  }
}
