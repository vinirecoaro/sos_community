import 'package:flutter/material.dart';
import 'package:sos_community/components/claims_list.dart';
import 'package:sos_community/models/claim.dart';

class ClaimsListScreen extends StatefulWidget {
  const ClaimsListScreen({super.key});

  @override
  State<ClaimsListScreen> createState() => _ClaimsListScreenState();
}

List<Claim> claimList = [
  // Objeto 1
  Claim(
    lat: -23.5505,
    lon: -46.6333,
    description: "Buraco na rua principal.",
    pictureLink: "https://example.com/buraco.jpg",
    title: "Buraco na Rua",
    date: DateTime(2024, 4, 28),
  ),
  // Objeto 2
  Claim(
    lat: -22.9068,
    lon: -43.1729,
    description: "Poste de luz queimado.",
    pictureLink: "https://example.com/poste.jpg",
    title: "Poste Queimado",
    date: DateTime(2024, 4, 29),
  ),
  // Objeto 3
  Claim(
    lat: 40.7128,
    lon: -74.0060,
    description: "Vazamento de água na calçada.",
    pictureLink: "https://example.com/vazamento.jpg",
    title: "Vazamento de Água",
    date: DateTime(2024, 4, 30),
  ),
  // Objeto 4
  Claim(
    lat: 51.5074,
    lon: -0.1278,
    description: "Semáforo quebrado no cruzamento.",
    pictureLink: "https://example.com/semaforo.jpg",
    title: "Semáforo Quebrado",
    date: DateTime(2024, 4, 27),
  ),
  // Objeto 5
  Claim(
    lat: 34.0522,
    lon: -118.2437,
    description: "Grafite em edifício público.",
    pictureLink: "https://example.com/grafite.jpg",
    title: "Grafite em Prédio",
    date: DateTime(2024, 4, 26),
  ),
];

class _ClaimsListScreenState extends State<ClaimsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Reclamações"),
        backgroundColor: const Color.fromARGB(255, 11, 109, 60),
      ),
      body: Column(
        children: [Expanded(child: ClaimsList(claimList))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "add_claim_screen",
              arguments: Claim(
                  lat: 0,
                  lon: 0,
                  description: "",
                  pictureLink: "",
                  title: "",
                  date: DateTime(2024)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
