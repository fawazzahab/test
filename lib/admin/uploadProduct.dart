import 'dart:io';
import 'package:flutter_app/admin/adminShop.dart';
import 'package:flutter_app/screen/ItemsScreen.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/products.dart';
import 'package:flutter_app/widgets/productsModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class uploadProduct extends StatelessWidget {
  static const String routeName = "/uploadProduct";
  String _name,_price,_Link,_desciption,_category;
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
  final _products=products();
  List<String> categoryList = <String>[
    "cleanning",
    "vegetables",
    "grain",
    "canned food",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(' add items'),
            actions: <Widget>[
              FlatButton(
                child: Row(
                  children: <Widget>[Text('view all item')],
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(adminShop.routeName);
                },
              ),
            ]
        ),
      body:Form(
        key: _globalKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'name '),
              onChanged: (value) {

              _name= value.trim();
                }),

          SizedBox(
            height: 10,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'descrition'),
              onChanged: (value) {

                  _desciption = value.trim();
                }),
          TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'price'),
              onChanged: (value) {

                _price = value.trim();
              }),
          SizedBox(
            height: 10,
          ),
          DropdownButton(
            items: categoryList
                .map((value) => DropdownMenuItem(
              child: Text(
                value,
              ),
              value: value,
            ))
                .toList(),
            onChanged: (selectedType) {
                _category = selectedType;

            },
            value: _category,
            isExpanded: false,
            hint: Text('select item category'),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            onPressed: (){
      uploadImage();

              },

            child: Text("add photo"),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
              onPressed: (){
                if(_globalKey.currentState.validate()){
                  _globalKey.currentState.save();

                  _products.addProduct(productsModel(
                    Pcategory: _category,
                    Pname: _name,
                    Pprice: _price,
                      imageUrl:_Link,
                    Pdescription: _desciption
                  ));
                }
                _globalKey.currentState.reset();
              },
            child: Text("add product"),
          ),
        ],
      ),
      ));
  }
  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;


    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null){
        //Upload to Firebase

          String now = DateTime.now().toString() ;
        UploadTask uploadTask =
        _storage.ref().child(image.toString() +now +".jpg").putFile(file);
        var downloadUrl = await (await uploadTask).ref.getDownloadURL();


          _Link = downloadUrl;

      } else {
        print('No Path Received');
      }

    } else {
      print('Grant Permissions and try again');
    }


}




}
