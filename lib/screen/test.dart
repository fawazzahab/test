import 'dart:io';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/products.dart';
import 'package:flutter_app/models/products.dart';
import 'package:flutter_app/screen/homeScreen.dart';
import 'package:flutter_app/screen/loginScreen.dart';
import 'package:flutter_app/widgets/productsModel.dart';

import '../constance.dart';


class test extends StatefulWidget {
  static const String routeName = "/test";

  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {

  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  final _store = products();
  List<productsModel> _products;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: kUnActiveColor,
              currentIndex: _bottomBarIndex,
              fixedColor: kMainColor,
              onTap: (value) async {


              },
              items: [
                BottomNavigationBarItem(
                    title: Text('Test'), icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    title: Text('Test'), icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    title: Text('Sign Out'), icon: Icon(Icons.close)),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: kMainColor,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: <Widget>[
                  Text(
                    'canned food',
                    style: TextStyle(
                      color: _tabBarIndex == 0 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 0 ? 16 : null,
                    ),
                  ),
                  Text(
                    'grain',
                    style: TextStyle(
                      color: _tabBarIndex == 1 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 1 ? 16 : null,
                    ),
                  ),
                  Text(
                    'vegetables',
                    style: TextStyle(
                      color: _tabBarIndex == 2 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 2 ? 16 : null,
                    ),
                  ),
                  Text(
                    'cleanning',
                    style: TextStyle(
                      color: _tabBarIndex == 3 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 3 ? 16 : null,
                    ),
                  ),
                ],
              ),
            ),

          ),
        ),
        Material(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {

                      },
                      child: Icon(Icons.shopping_cart))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }


  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<productsModel> products = [];
          for (var doc in snapshot.data.docs) {
            var data = doc.data();
            products.add(productsModel(
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
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () {

                },
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image(
                        fit: BoxFit.fill,
                        image:NetworkImage(products[index].imageUrl),
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
                                  products[index].Pname,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('\$ ${products[index].Pprice}')
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
            itemCount: products.length,
          );
        } else {
          return Center(child: Text('Loading...'));
        }
      },
    );
  }
}