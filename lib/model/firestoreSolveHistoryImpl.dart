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

  Stream<QuerySnapshot> _solveStream;

  FirestoreSolveHistoryImpl() {
    FirebaseAuth.instance.authStateChanges().listen(
      (User u) {
        if (u == null) {
          solves = [];
          notifyListeners();
          return;
        }

        String uid = FirebaseAuth.instance.currentUser.uid;
        _solveStream = FirebaseFirestore.instance
            .collection('users/$uid/solves')
            .orderBy("timestamp", descending: true)
            .snapshots();

        _solveStream.listen(
          (QuerySnapshot snapshot) {
            List<QueryDocumentSnapshot> docs = snapshot.docs;
            print(docs.map((e) => e.data()));
            solves = docs.where((e) => e.exists).map((e) {
              print("data: ${e.data()}");
              return Solve.fromJson(e.data());
            }).toList();
            notifyListeners();
          },
        );
      },
    );
  }

  @override
  void add(Solve solve) {
    print("adding solve to firestore: ${solve.toJson()}");
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
