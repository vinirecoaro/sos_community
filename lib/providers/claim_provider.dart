import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:sos_community/models/claim.dart';

class ClaimProvider extends ChangeNotifier {
  var ref = FirebaseDatabase.instance.ref("claims");
  List<Claim> claimList = [];
  bool _isInitialized = false;

  ClaimProvider() {
    if (!_isInitialized) {
      getList();
      _isInitialized = true;
    }
  }

  void getList() {
    var future = ref.get();
    future.then((value) {
      for (var item in value.children) {
        Map<String, dynamic> values =
            Map<String, dynamic>.from(item.value as Map);
        var claim = Claim.fromJson(values);
        claimList.add(claim);
      }
      notifyListeners();
    });
  }

  void insert(Claim claim) {
    var newRef = ref.push();
    var id = newRef.key;
    claim.id = id;
    var claimJson = claim.toJson();
    var future = newRef.set(claimJson);
    future.then((value) {
      claimList.add(claim);
      notifyListeners();
    });
  }

  void delete(Claim claim) {
    var future = ref.child(claim.id!).remove();
    future.then((value) {
      claimList.removeWhere((element) => element.id == claim.id);
      notifyListeners();
    });
  }
}
