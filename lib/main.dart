import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/admin/editProduct.dart';
import 'package:flutter_app/providers/CartItem.dart';
import 'package:flutter_app/screen/CartScreen.dart';
import 'package:flutter_app/screen/ItemsScreen.dart';
import 'package:flutter_app/screen/MoneyDonation.dart';
import 'package:flutter_app/screen/productInfo.dart';
import 'package:flutter_app/screen/verificationScreen.dart';
import 'package:provider/provider.dart';
import 'screen/foodDonationScreen.dart';
import 'screen/homeScreen.dart';
import 'screen/loginScreen.dart';
import 'screen/signupScreen.dart';
import 'screen/MoneyDonation.dart';
import 'admin/uploadProduct.dart';
import 'package:flutter_app/admin/adminShop.dart';
import 'package:flutter_app/screen/test.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider<CartItem>(
      child: ChangeNotifierProvider<CartItem>(
          create: (context)=>CartItem()
      ),
   );

  
  runApp(MaterialApp(

    title: 'login app',
    theme: ThemeData(primaryColor: Colors.blue),
    home: loginScreen(),

    routes: {
      test.routeName: (ctx) => test(),
      ItemsScreen.routeName: (ctx) => ItemsScreen(),
      uploadProduct.routeName: (ctx) => uploadProduct(),
      MoneyDonation.routeName: (ctx) => MoneyDonation(),
      verificationScreen.routeName: (ctx) => verificationScreen(),
      foodDonationScreen.routeName: (ctx) => foodDonationScreen(),
      signupScreen.routeName: (ctx) => signupScreen(),
      loginScreen.routeName: (ctx) => loginScreen(),
      homeScreen.routeName: (ctx) => homeScreen(),
      adminShop.routeName: (ctx) => adminShop(),
      editProduct.routeName: (ctx) => editProduct(),
      productInfo.routeName:(ctx)=>productInfo(),
      CartScreen.routeName:(ctx)=>CartScreen(),


    },
  ));
}
