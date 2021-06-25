import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/widgets/productsModel.dart';

import '../constance.dart';
class products{
  final FirebaseFirestore _Firestore= FirebaseFirestore.instance;

  addProduct(productsModel p1){
    _Firestore.collection(prodcutsCollenction).add(
{
  Productcategory:p1.Pcategory,
  Link:p1.imageUrl,
  productsName:p1.Pname,
  Productdescription:p1.Pdescription,
  ProductsPrice:p1.Pprice
} );
  }


  Stream<QuerySnapshot>loadProducts(){
    return _Firestore.collection(prodcutsCollenction).snapshots();
  }
  DeleteProducts(documentID){
    
  return _Firestore.collection(prodcutsCollenction).doc(documentID).delete();

}


}