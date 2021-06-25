import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screen/homeScreen.dart';
import 'package:flutter_app/screen/verificationScreen.dart';
import 'package:provider/provider.dart';
//import '../models/authentications.dart';
import 'package:flutter_app/screen/loginScreen.dart';
import 'loginScreen.dart';

class signupScreen extends StatefulWidget {
  static const routeName = "/signup";
  @override
  _loginScreenState createState() => _loginScreenState();
}

bool validateStructure(String value) {
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

class _loginScreenState extends State<signupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _passwordController = new TextEditingController();

  String _password, _email;
  final auth = FirebaseAuth.instance;
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

//await Provider.of<authentication>(context, listen:false).signup(_authData['email'], _authData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SignUp'),
          actions: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[Text('login'), Icon(Icons.person)],
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(loginScreen.routeName);
              },
            )
          ],
        ),
        body: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
            Colors.purple,
            Colors.green,
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
                            decoration: InputDecoration(labelText: ' password'),
                            obscureText: true,
                            controller: _passwordController,
                            validator: (value) {
                              if (value.isEmpty ||
                                  !validateStructure(value) ||
                                  value.length < 6) {
                                return 'your password have to include '
                                    '\n Minimum 1 Upper case'
                                    '\n Minimum 1 lowercase'
                                    '\n Minimum 1 Numeric Number'
                                    '\n and password length more than 6';
                              }

                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _password = value.trim();
                              });
                            }),
                        //confirm

                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'confirm password'),
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty || value != _password) {
                              return 'invalid password';
                            }
                            signin();
                            return null;
                          },
                        ),
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

  Future signin()async{
    await auth.createUserWithEmailAndPassword(
        email: _email, password: _password);

   await Navigator.of(context).pushReplacementNamed(
        verificationScreen.routeName);

  }
}
