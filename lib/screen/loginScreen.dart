import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/admin/uploadProduct.dart';
import 'package:flutter_app/screen/ItemsScreen.dart';
import 'package:flutter_app/screen/foodDonationScreen.dart';
import 'package:flutter_app/screen/homeScreen.dart';
import 'package:provider/provider.dart';
//import '../models/authentications.dart';
import 'homeScreen.dart';
import 'signupScreen.dart';
import 'package:flutter_app/screen/test.dart';
import 'package:flutter_app/admin/adminShop.dart';

class loginScreen extends StatefulWidget {
  static const routeName = "/login";
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String _password, _email;
  final auth = FirebaseAuth.instance;
  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('an error occured'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.of(context)
          .pushReplacementNamed(homeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showErrorDialog("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        _showErrorDialog("Wrong password provided for that user.");
      }
    }
    User user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('login'),
          actions: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[Text('signup'), Icon(Icons.person_add)],
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(signupScreen.routeName);
              },
            ),
            FlatButton(
              child: Row(
                children: <Widget>[Text('add product'), Icon(Icons.person_add)],
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(uploadProduct.routeName);
              },
            ),
            FlatButton(
              child: Row(
                children: <Widget>[Text("items"), Icon(Icons.person_add)],
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(ItemsScreen.routeName);
              },
            ),
          ],
        ),
        body: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
            Colors.lime,
            Colors.deepOrangeAccent,
          ]))),
          Center(
              child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
                height: 260,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                        child: Column(
                      children: <Widget>[
                        //email
                        TextFormField(
                            decoration: InputDecoration(labelText: 'email'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return 'invalid email';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _email = value.trim();
                              });
                            }),
                        //pass
                        TextFormField(
                            decoration: InputDecoration(labelText: 'password'),
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty || value.length <= 5) {
                                return 'invalid password';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _password = value.trim();
                              });
                            }),
                        RaisedButton(
                          child: Text('submit'),
                          onPressed: () {
                            _submit();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Colors.blue,
                          textColor: Colors.white,
                        )
                      ],
                    )))),
          )),
        ]));
  }
}
