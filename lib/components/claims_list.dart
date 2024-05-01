import 'package:flutter/material.dart';
import 'package:sos_community/components/claim_list_tile.dart';
import 'package:sos_community/models/claim.dart';

class ClaimsList extends StatelessWidget {
  const ClaimsList(this.claimList, {super.key});

  final List<Claim> claimList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemCount: claimList.length,
        itemBuilder: (context, index) {
          Claim claim = claimList[index];
          return ClaimListTile(claim);
        },
      ),
    );
  }
}
