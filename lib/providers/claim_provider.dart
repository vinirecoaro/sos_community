import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:sos_community/models/claim.dart';

class ClaimProvider extends ChangeNotifier {
  var ref = FirebaseDatabase.instance.ref("claims");
  List<Claim> claimList = [];

  void insert(Claim claim) {
    var newRef = ref.push();
    var id = newRef.key;
    var claimJson = claim.toJson();
    var future = newRef.set(claimJson);
    future.then((value) {
      claim.id = id;
      claimList.add(claim);
      notifyListeners();
    });
  }

  void delete(Claim claim) {}
}
