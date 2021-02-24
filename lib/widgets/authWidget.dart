import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key key}) : super(key: key);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  Future<void> signInWithGoogle() async {
    print("google auth");
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle buttonStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
    return SimpleDialog(
      title: Text("Sign in"),
      contentPadding: EdgeInsets.all(12),
      children: [
        // SignInButtonBuilder(
        //   text: "Sign in with email",
        //   iconColor: Colors.grey[600],
        //   icon: Icons.email,
        //   textColor: Colors.black,
        //   onPressed: () => print("email auth"),
        //   backgroundColor: Colors.white,
        // ),
        // Divider(),
        SignInButton(Buttons.GoogleDark, onPressed: signInWithGoogle),
        Divider(),
        TextButton(
            onPressed: () async {
              print("anonymous login");
              await FirebaseAuth.instance.signInAnonymously();
              Navigator.pop(context);
            },
            child: Text("Continue as guest"))
      ],
    );
  }
}
