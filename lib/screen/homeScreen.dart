import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/admin/uploadProduct.dart';
import 'package:flutter_app/screen/foodDonationScreen.dart';
import 'package:flutter_app/screen/loginScreen.dart';

import 'ItemsScreen.dart';

class homeScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  User user;
  Future logout()async{
    user=auth.currentUser;
   return await auth.signOut();
  }
  static const routeName = "/home";
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('home Screen'),
          actions: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[Text('log out'), Icon(Icons.person)],
              ),
              onPressed: () {
                logout();
                Navigator.of(context)
                    .pushReplacementNamed(loginScreen.routeName);
              },
            ),
          ],
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Welcome To TooFoodToGO',style: TextStyle(fontStyle: FontStyle.italic, fontSize: 30),),

                FlatButton(
                  child: Row(
                    children: <Widget>[Text('add item'),],
                  ),
                  onPressed: () {
                    logout();
                    Navigator.of(context)
                        .pushReplacementNamed(uploadProduct .routeName);
                  },
                ),
                FlatButton(
                  child: Row(
                    children: <Widget>[Text('view items'), ],
                  ),
                  onPressed: () {
                    logout();
                    Navigator.of(context)
                        .pushReplacementNamed(ItemsScreen .routeName);
                  },
                ),
                FlatButton(
                  child: Row(
                    children: <Widget>[Text('donation food'),],
                  ),
                  onPressed: () {
                    logout();
                    Navigator.of(context)
                        .pushReplacementNamed(foodDonationScreen.routeName);
                  },
                ),
              ],
            )
        )
    );
  }
}
