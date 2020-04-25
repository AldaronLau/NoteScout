
// import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget{
  _HomepageST createState() => _HomepageST();
}

class _HomepageST extends State<Homepage> {
  File _image;

  Future getImage() async {
    // var image = await ImagePicker.pickImage(source: ImageSource.camera);

    // setState(() {
    //   _image = image;
    // });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text("Select an Image")
      ),
      body: Center(
          child: _image == null
              ? Text("No image selected")
              : Image.file(_image)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Select one image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

}
