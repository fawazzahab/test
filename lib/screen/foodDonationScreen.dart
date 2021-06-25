import 'package:flutter/material.dart';
import 'package:flutter_app/admin/uploadProduct.dart';
import 'package:flutter_app/screen/MoneyDonation.dart';
import 'signupScreen.dart';
import 'homeScreen.dart';

class foodDonationScreen extends StatefulWidget {
  static const routeName = "/foodDonationScreen";

  @override
  _foodDonationScreenState createState() => _foodDonationScreenState();
}

class _foodDonationScreenState extends State<foodDonationScreen> {
  var _foodType, selectedPersson, phone, Size, location;
  List<String> _foodTypes = <String>[
    "riz",
    "soup",
    "desert",
    "full meal",
  ];
  List<String> persons = <String>[
    "ahmad",
    "fawaz",
    "abed",
    "mohamad",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('food donation'),
          actions: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[Text('home'),],
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(homeScreen.routeName);
              },
            ),
          ],
        ),
        body: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
            Colors.blue,
            Colors.green,
          ]))),
          Center(
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                    height: 600,
                    width: 350,
                    padding: EdgeInsets.all(16),
                    child: Form(
//
                        child: Column(
                      children: <Widget>[
                        TextFormField(
                            decoration:
                                InputDecoration(labelText: 'phone number'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "this can't be empty";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              phone = value;
                            }),
                        Text(""),
                        TextFormField(
                            decoration: InputDecoration(
                                labelText: 'for how many person is the meal'),
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return ' please enter a number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              Size = value;
                            }),
                        TextFormField(
                            decoration: InputDecoration(labelText: 'address'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "this can't be empty";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              location = value;
                            }),
                        Text(""),
                        Text(""),
                        DropdownButton(
                          items: _foodTypes
                              .map((value) => DropdownMenuItem(
                                    child: Text(
                                      value,
                                    ),
                                    value: value,
                                  ))
                              .toList(),
                          onChanged: (selectedType) {
                            setState(() {
                              _foodType = selectedType;
                            });
                          },
                          value: _foodType,
                          isExpanded: false,
                          hint: Text('select food type'),
                        ),
                        Text(""),
                        Text(""),
                        SizedBox(
                          height: 40.0,
                        ),
                        DropdownButton(
                          items: persons
                              .map((value) => DropdownMenuItem(
                                    child: Text(
                                      value,
                                    ),
                                    value: value, 
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedPersson = value;
                            });
                          },
                          value: selectedPersson,
                          isExpanded: false,
                          hint: Text('select food type'),
                        ),
                        Text(""),
                        Text(""),
                        RaisedButton(
                          child: Text('submit'),
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),

                      ],
                    )))),
          )
        ]));
  }
}
