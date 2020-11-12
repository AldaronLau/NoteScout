import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:note_scout/main.dart';

void main() => runApp(CameraPart());

class CameraPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page(),
    );
  }
}

class Page extends StatefulWidget {
  @override
  Ccamera createState() => Ccamera();
}

class Ccamera extends State<Page> {
  ///Defines an image and how its selected
  File Iimage;
  final selector = ImagePicker();

  ///Chooses image from phone capture
  Future GetSome() async {
    final PickedFile = await selector.getImage(source: ImageSource.camera);

    setState(() {
      if (PickedFile != null) {
        Iimage = File(PickedFile.path);
      } else {
        print("Nothing is there");
      }
    });
  }

  ///Builds widget that opens the camera
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: APPCOLOR,
        title: Text("NoteScout Official Camera",
            style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Iimage == null
            ? Text("No image has been selected")
            : Image.file(Iimage),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: APPCOLOR,
        onPressed: GetSome,
        tooltip: 'get an image already',
        child: Icon(Icons.add_a_photo, color: Colors.black),
      ),
    );
  }
}
