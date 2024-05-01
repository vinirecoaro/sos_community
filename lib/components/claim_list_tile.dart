import 'package:flutter/material.dart';
import 'package:sos_community/models/claim.dart';

class ClaimListTile extends StatelessWidget {
  const ClaimListTile(this.claim, {super.key});

  final Claim claim;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(claim.title),
    );
  }
}
