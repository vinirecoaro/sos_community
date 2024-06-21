import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:sos_community/models/claim.dart';

class ClaimProvider extends ChangeNotifier {
  var databaseRef = FirebaseDatabase.instance.ref("claims");
  var storageRef = FirebaseStorage.instance;
  List<Claim> claimList = [];
  bool _isInitialized = false;
  bool isLoading = false;
  List<String> imagesUrl = [];

  ClaimProvider() {
    if (!_isInitialized) {
      getList();
      _isInitialized = true;
    }
  }

  void getList() {
    isLoading = true;
    notifyListeners();

    try {
      var future = databaseRef.get();
      future.then((value) {
        for (var item in value.children) {
          Map<String, dynamic> values =
              Map<String, dynamic>.from(item.value as Map);
          var claim = Claim.fromJson(values);
          claimList.add(claim);
        }
        isLoading = false;
        notifyListeners();
      });
    } catch (error) {
      isLoading = false;
      notifyListeners();
    }
  }

  void insert(Claim claim) {
    var newRef = databaseRef.push();
    var id = newRef.key;
    claim.id = id;

    if (claim.picturesPath != null) {
      var urlImages = saveImages(claim.picturesPath!, id.toString());
      urlImages.then((value) {
        claim.picturesPath = imagesUrl;
        var claimJson = claim.toJson();
        var future = newRef.set(claimJson);
        future.then((value) {
          claimList.add(claim);
          notifyListeners();
        });
      });
    }
  }

  void delete(Claim claim) {
    var future = databaseRef.child(claim.id!).remove();
    future.then((value) {
      claimList.removeWhere((element) => element.id == claim.id);
      notifyListeners();
    });
  }

  Future<void> saveImages(List<String> imagesPath, String id) async {
    for (var i = 0; i < imagesPath.length; i++) {
      var ref = storageRef.ref().child(id).child("picture$i");
      var imageFile = File(imagesPath[i]);
      await ref.putFile(imageFile);
      var url = await ref.getDownloadURL();
      imagesUrl.add(url);
    }
  }
}
