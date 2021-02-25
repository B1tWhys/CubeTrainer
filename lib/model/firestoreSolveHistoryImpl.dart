import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubetrainer/model/solve.dart';
import 'package:cubetrainer/model/solveHistory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirestoreSolveHistoryImpl
    with ChangeNotifier
    implements SolveHistoryInterface {
  @override
  List<Solve> solves = [];

  @override
  void add(Solve solve) {
    print("adding solve to firestore");
    String uid = FirebaseAuth.instance.currentUser.uid;
    CollectionReference user =
        FirebaseFirestore.instance.collection('users/$uid/solves');
    user.doc(solve.id).set(solve.toJson()).then((value) {
      print("solve added to firestore");
      this.notifyListeners();
    }).onError((error, stackTrace) {
      print("failed to update solves");
      throw error;
    });
  }
}
