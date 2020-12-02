 import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
 import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';



 void main() => runApp(MyHomePage());


 class MyHomePage extends StatefulWidget {
   MyHomePage(): super();

   final String word = "Images gets saved into strings";

   @override
   _MyHomePageState createState() => new _MyHomePageState();
 }

 class _MyHomePageState extends State<MyHomePage> {
   File _image;

   Future getImage() async {
     var image = await ImagePicker.pickImage(source: ImageSource.gallery);

     setState(() {
       _image = image;
     });
   }

   @override
   Widget build(BuildContext context) {
     return new Scaffold(
       appBar: new AppBar(
         title: new Text('Select a Note'),
       ),
       body: new Center(
         child: _image == null
             ? new Text('No image selected.')
             : new Image.file(_image),
       ),
       floatingActionButton: new FloatingActionButton(
         onPressed: getImage,
         tooltip: 'Pick Image',
         child: new Icon(Icons.add_a_photo),
       ),

     );
     Align(
         alignment: Alignment.topLeft,
         child: IconButton(
           icon: Icon(Icons.arrow_back_sharp),
           color: Colors.grey,
           iconSize: 55,
           onPressed: (){
             Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) {
                   return UplUD();
                 })
             );
           },
         )
     )
   }
 }