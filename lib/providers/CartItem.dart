
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/productsModel.dart';
class CartItem extends ChangeNotifier {
    List<productsModel> products = [];

  addProduct(productsModel product) {
    products.add(product);
    notifyListeners();
  }

  deleteProduct(productsModel product) {
    products.remove(product);
    notifyListeners();
  }
}