 import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';

 void main() => runApp(MyHomePage());


 class MyHomePage extends StatefulWidget {
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
   }
 }