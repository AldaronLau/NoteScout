import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_scout/uploader.dart';


//void main() => runApp(CameraPart());

class CameraPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page(),
    );
  }
}


class Page extends StatefulWidget{
  @override
  Ccamera createState() => Ccamera();
}


class Ccamera extends State<Page>{
///Defines an image and how its selected
  File Iimage;
  final selector = ImagePicker();

  ///Chooses image from phone capture
  Future GetSome() async {
    final PickedFile = await selector.getImage(source: ImageSource.camera);

    setState(() {
      if (PickedFile != null){
        Iimage = File(PickedFile.path);
      }else{
        print("Nothing is there");
      }
    });
  }

  ///Builds widget that opens the camera
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notescout official camera"),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
      body: Stack(children: <Widget>[
      Align(
      alignment: Alignment.bottomCenter,
        child: Iimage == null
            ? Text("No image has been selected")
            : Image.file(Iimage),
      ),
      Align(
      alignment: Alignment.center,
      child: RaisedButton(
      child: Text("Take Picture"),
    color: Colors.blue,
        onPressed: GetSome,

      ),
    ),
    Align( alignment: Alignment.topLeft,
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
    ),

    ],
      )
    );
  }
}