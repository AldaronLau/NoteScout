import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Upload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notescout"),
        centerTitle: true,
        backgroundColor:  Colors.red,
      ),
      body: Container(
        color: Colors.blue,
        child: Image.network("http://images.freeimages.com/images/previews/bf6/note-paper-1155539.jpg"),

      ),
      floatingActionButton: RaisedButton(
        child: Text("Uplpoad"),
        color:  Colors.red,
        onPressed: () {
          print('Uploading');

        },
      ),
    );
  }
}
