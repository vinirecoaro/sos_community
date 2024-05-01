import 'package:flutter/material.dart';

class ClaimsListScreen extends StatefulWidget {
  const ClaimsListScreen({super.key});

  @override
  State<ClaimsListScreen> createState() => _ClaimsListScreenState();
}

class _ClaimsListScreenState extends State<ClaimsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Reclamações"),
        backgroundColor: const Color.fromARGB(255, 11, 109, 60),
      ),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
