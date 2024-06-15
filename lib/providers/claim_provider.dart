import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:sos_community/models/claim.dart';

class ClaimProvider extends ChangeNotifier {
  var ref = FirebaseDatabase.instance.ref("claims");
  List<Claim> claimList = [];

  void insert(Claim claim) {
    var future = ref.set(claim);
    future.then((value) {
      claimList.add(claim);
      notifyListeners();
    });
  }
}
