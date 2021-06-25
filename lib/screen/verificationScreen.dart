import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screen/homeScreen.dart';

class verificationScreen extends StatefulWidget {
  static const routeName = "/verificationScreen";
  @override
  _verificationScreenState createState() => _verificationScreenState();
}

class _verificationScreenState extends State<verificationScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerification();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
            child: Text('an email has been send to ${user.email} please verify')),
    );
  }

  Future<void> checkEmailVerification() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacementNamed(homeScreen.routeName);
    }
  }
}
