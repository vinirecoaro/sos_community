import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sos_community/models/claim.dart';

class ClaimListTile extends StatelessWidget {
  const ClaimListTile(this.claim, {super.key});

  final Claim claim;

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return ListTile(
      onTap: () {},
      title: Text(claim.title),
      subtitle: Text(formatter.format(claim.date)),
      trailing: Text(claim.status),
    );
  }
}
