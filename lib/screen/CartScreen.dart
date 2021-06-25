import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/providers/CartItem.dart';
import 'package:flutter_app/widgets/productsModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/constance.dart';
class CartScreen extends StatelessWidget {
  static const routeName = "/CartScreen";

  @override
  Widget build(BuildContext context) {
    List<productsModel>products=Provider.of<CartItem>(context).products;
     final double screenheight=MediaQuery.of(context).size.height;
    final double screenwidth=MediaQuery.of(context).size.width;
     return Scaffold(
         appBar:AppBar(
          title:Text("My cart",style:TextStyle(color:Color(0xFF000000))),
           backgroundColor: Color(0xFFFFFFFF),
            leading:GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
              child:Icon(
                Icons.arrow_back,
                color:Color(0xFF000000),
              ),
     ),
    ),
      body: Column(
        children: [
          LayoutBuilder(
            builder:(context,constraines) {
              if(products.isNotEmpty){
              return Expanded(
                child: ListView.builder(itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      height: screenheight * .15,
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: screenheight * .15 / 2,
                            backgroundImage: NetworkImage(
                                products[index].imageUrl),

                          ),
                          Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        Text(products[index].Pname,
                                          style: TextStyle(fontSize: 18,
                                              fontWeight: FontWeight.bold),),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(products[index].Pprice + "L.L",
                                          style: TextStyle(fontSize: 15,
                                              fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                      products[index].Pquantity.toString(),
                                      style: TextStyle(fontSize: 15,
                                          fontWeight: FontWeight.bold),),
                                  ),

                                ]
                            ),
                          ),
                        ],
                      ),
                      color: kSecondaryColor,
                    ),
                  );
                },
                  itemCount: products.length,
                ),
              );}
                else
                  {
                  return Center(
                    child:Text("empty cart"),
                    );

                };
            },
          ),
          ButtonTheme(
            minWidth:screenwidth,
            height: screenheight*.20,
          child: RaisedButton(
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight:Radius.circular(10),
                                              topLeft: Radius.circular(10))
    ),
            onPressed:(){},
              child:Text("order"),
                color: kMainColor,
    ),
          )
        ],
      ),
    );
  }
}
