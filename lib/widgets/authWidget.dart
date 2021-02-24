import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key key}) : super(key: key);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  String email = null;
  String password = null;

  @override
  Widget build(BuildContext context) {
    TextStyle buttonStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
    return SimpleDialog(
      title: Text("Sign in"),
      contentPadding: EdgeInsets.all(12),
      children: [
        SignInButtonBuilder(
          text: "Sign in with Email",
          iconColor: Colors.grey[600],
          icon: Icons.email,
          textColor: Colors.black,
          onPressed: () => print("email auth"),
          backgroundColor: Colors.white,
        ),
        Divider(),
        SignInButton(
          Buttons.GoogleDark,
          onPressed: () => print("google auth"),
        ),
        Divider(),
        TextButton(
            onPressed: () => print("guest auth"),
            child: Text("Continue as guest"))
      ],
    );
  }
}
