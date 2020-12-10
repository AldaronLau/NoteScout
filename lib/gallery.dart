import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:note_scout/main.dart';
import'package:note_scout/uploader.dart';


void main() => runApp(Gallery());

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => new _GalleryState();
}

class _GalleryState extends State<Gallery> {

  File _image;
  String _64;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    var _PATh = await ImagePicker.pickImage(source: ImageSource.gallery);

    print(_64);
    {savePictureNote ( 'picture/picture', _64);}

    setState(() {
      _image = image;
      final _Encode = _PATh.readAsBytesSync();
      _64 = base64Encode(_Encode);

    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Gallery"),
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent,
        ),
      body: Stack(children: <Widget>[
      Align(
        child: _image == null
            ? new Text('No image selected.')
            : new Image.file(_image),
    ),
     Align(
      child: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo, color: Colors.black),
        backgroundColor: Colors.lightBlueAccent,
    )
    ),
//      Align(
//        alignment: Alignment.bottomCenter,
//        child: new FloatingActionButton(
//          tooltip: 'Pick Image',
//          child: new Icon(Icons.add_a_photo, color: Colors.black),
//        onPressed: () async


    ]
    ),
    );
  }
}
