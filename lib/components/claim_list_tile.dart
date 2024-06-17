import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sos_community/models/claim.dart';
import 'package:sos_community/routes.dart';

class ClaimListTile extends StatelessWidget {
  const ClaimListTile(this.claim, {super.key});

  final Claim claim;

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return ListTile(
      onTap: () {
        claim.edit = true;
        Navigator.pushNamed(context, Routes.ADD_EDIT_CLAIM, arguments: claim);
      },
      title: Text(claim.title),
      subtitle: Text(formatter.format(claim.date)),
      trailing: Text(claim.status),
    );
  }
}
