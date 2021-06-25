


import 'dart:io';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/products.dart';
import 'package:flutter_app/screen/homeScreen.dart';
import 'package:flutter_app/screen/loginScreen.dart';
import 'package:flutter_app/screen/productInfo.dart';
import 'package:flutter_app/widgets/productsModel.dart';

import '../constance.dart';




class ItemsScreen extends StatefulWidget {
  static const String routeName = "/ItemsScreen";
  final FirebaseFirestore _Firestore= FirebaseFirestore.instance;
  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final _products=products();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:kMainColor,
          title: Text('items'),

          actions: <Widget>[
      FlatButton(
      child: Row(
          children: <Widget>[Text('home Screen'), Icon(Icons.person_add)],
    ),
     onPressed: () {
     Navigator.of(context)
        .pushReplacementNamed(homeScreen.routeName);
    },
    ),
  ]
    ),
      body: StreamBuilder<QuerySnapshot>(
        stream:_products.loadProducts(),
        builder: (context,snapshot){
          List <productsModel>Lproducts = [];
          if(snapshot.hasData) {
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              Lproducts.add(productsModel(
                  Pname: data[productsName],
                  Pprice: data[ProductsPrice],
                  imageUrl: data[Link],
                  Pdescription:data[Productdescription],
                Pcategory: data[Productcategory],
              ));
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

                child: GestureDetector(
                  onTapUp: (details) async {
                    Navigator.of(context).pushNamed(productInfo.routeName,arguments:Lproducts[index]);
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(

                          fit: BoxFit.fill,
                          image: NetworkImage(Lproducts[index].imageUrl),

                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    Lproducts[index].Pname,
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('\$ ${Lproducts[index].Pprice}'+'L.L')
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              itemCount: Lproducts.length,
            );
          }
          else{
            return Center(child: Text('loading...'));
          }
        },
      ),
    );
  }
}