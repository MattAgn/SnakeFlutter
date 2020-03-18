import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  _onSignInWithGoogle() {
    _handleSignIn()
        .then((FirebaseUser user) => print(user))
        .catchError((e) => print(e));
  }

  Future<FirebaseUser> _onSignInWithEmail() async {
    print('wesh');
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: 'mat.alingrin+android@gmail.com',
      password: 'papapa',
    ))
        .user;
    print("over");
    return user;
  }

  signup() {
    print("toto");
    _onSignInWithEmail()
        .then((FirebaseUser user) => print(user))
        .catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Login with google"),
              onPressed: _onSignInWithGoogle,
            ),
            RaisedButton(
              child: Text("Signup with email"),
              onPressed: signup,
            )
          ],
        ),
      ),
    );
  }
}
