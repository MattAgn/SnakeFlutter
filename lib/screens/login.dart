import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email;
  String _password;
  String _firebaseError;
  bool _isSignupLoading = false;
  bool _isLoginLoading = false;
  FirebaseUser _user;

  _createUserInDb() {
    Firestore.instance
        .collection('users')
        .document(_user.uid)
        .setData({"bestScore": 0, "email": _user.email})
        .then((value) => print("saved"))
        .catchError((err) => print(err));
  }

  _onSubmitSignup() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      setState(() {
        _isSignupLoading = true;
      });
      try {
        final AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        _user = result.user;
        _createUserInDb();
        showDialog(
            context: context,
            child: AlertDialog(
              title: Text("Congrats!"),
              content: Text("You successfully signed up :)"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    formState.reset();
                  },
                  child: Text("I'm so happy!"),
                )
              ],
            ));
      } catch (err) {
        if (err is PlatformException) {
          _firebaseError = err.message;
          formState.validate();
        }
        print(err);
      } finally {
        setState(() {
          _isSignupLoading = false;
        });
      }
    }
  }

  _onSubmitLogin() async {
    final formState = _formKey.currentState;
    formState.save();
    if (formState.validate()) {
      setState(() {
        _isLoginLoading = true;
      });
      try {
        final AuthResult result = await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        final FirebaseUser user = result.user;
        showDialog(
            context: context,
            child: AlertDialog(
              title: Text("Congrats!"),
              content: Text("You successfully logged in :)"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    formState.reset();
                  },
                  child: Text("I'm so happy!"),
                )
              ],
            ));
        return user;
      } catch (err) {
        if (err is PlatformException) {
          _firebaseError = err.message;
          formState.validate();
        }
        print(err);
      } finally {
        setState(() {
          _isLoginLoading = false;
        });
      }
    }
  }

  String _validateEmail(String value) {
    try {
      assert(EmailValidator.validate(value));
    } catch (e) {
      return 'The email must be a valid email address.';
    }

    if (_firebaseError != null) {
      return " "; // we show the error message under the password field
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 6) {
      return 'The password must be at least 6 characters.';
    }

    if (_firebaseError != null) {
      return _firebaseError;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (newValue) => _email = newValue.trim(),
                validator: _validateEmail,
                textInputAction: TextInputAction.next,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                autovalidate: false,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                onChanged: (_) => _firebaseError = null,
                decoration: InputDecoration(
                  errorText: _firebaseError,
                  labelText: "Email",
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  hintText: "toto@gmail.com",
                  icon: Icon(
                    Icons.email,
                  ),
                ),
              ),
              TextFormField(
                onSaved: (newValue) => _password = newValue.trim(),
                textInputAction: TextInputAction.done,
                obscureText: true,
                autofocus: true,
                autovalidate: false,
                validator: _validatePassword,
                onChanged: (_) => _firebaseError = null,
                decoration: InputDecoration(
                  errorText: _firebaseError,
                  hintText: "azerty123",
                  labelText: "Password",
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  icon: Icon(
                    Icons.lock,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.greenAccent,
                    child: _isSignupLoading ? Loader() : Text("Sign up"),
                    onPressed: _onSubmitSignup,
                  ),
                  SizedBox(width: 30),
                  RaisedButton(
                    onPressed: _onSubmitLogin,
                    child: _isLoginLoading ? Loader() : Text("Log in"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
    );
  }
}
