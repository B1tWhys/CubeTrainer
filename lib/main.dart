import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/homeScreen.dart';

void main() {
  runApp(CubeTimer());
}

class CubeTimer extends StatelessWidget {
  final Future _initialization = Firebase.initializeApp();
  // .then((value) => FirebaseFirestore.instance.enablePersistence());
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cube Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        builder: (context, initializationSnapshot) {
          if (initializationSnapshot.hasError) {
            return Center(
              child: Text(
                "Something went wrong. Please refresh\n:/",
                textAlign: TextAlign.center,
              ),
            );
          }

          return StreamBuilder(
            builder: (context, authSnapshot) {
              if (initializationSnapshot.connectionState ==
                      ConnectionState.done &&
                  authSnapshot?.connectionState != ConnectionState.waiting) {
                return MyHomePage(title: "Cube Timer");
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            stream: auth.authStateChanges(),
          );
        },
        future: _initialization,
      ),
    );
  }
}
