import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sos_community/components/claims_list.dart';
import 'package:sos_community/components/custom_app_bar.dart';
import 'package:sos_community/models/claim.dart';
import 'package:sos_community/providers/claim_provider.dart';
import 'package:sos_community/routes.dart';

class ClaimsListScreen extends StatefulWidget {
  const ClaimsListScreen({super.key});

  @override
  State<ClaimsListScreen> createState() => _ClaimsListScreenState();
}

class _ClaimsListScreenState extends State<ClaimsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar("Lista de Reclamações"),
      // appBar: AppBar(
      //   title: const Text("Lista de Reclamações"),
      //   backgroundColor: const Color.fromARGB(255, 11, 109, 60),
      // ),
      body: Consumer<ClaimProvider>(builder: (context, claimProvider, child) {
        if (claimProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (claimProvider.claimList.isEmpty) {
          return const Center(child: Text('Nenhuma reclamação registrada'));
        } else {
          return Column(
            children: [Expanded(child: ClaimsList(claimProvider.claimList))],
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.ADD_EDIT_CLAIM,
              arguments: Claim(
                  lat: 0,
                  lon: 0,
                  description: "",
                  picturesPath: [],
                  title: "",
                  date: DateTime(2024)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
