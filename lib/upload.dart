import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:note_scout/camera.dart';
import 'package:note_scout/converter.dart';
import 'package:note_scout/gallery.dart';
import 'package:note_scout/faq.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_scout/permission.dart';
import 'package:note_scout/settings.dart';

void main() => runApp(MaterialApp(home: upload()));

class upload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notescout"),
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent, //blue color header
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
          margin: EdgeInsets.all(30.0),
          color: Colors.grey[400],
        ),
        floatingActionButton: RaisedButton(
            child: Text("Upload"),
            color: Colors.blue,
            onPressed: () {
              print('Uploading');

              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new UplUD()));
            }));
  }
}

class UplUD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose and Upload option"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 100),
                  icon: Icon(Icons.camera),
                  iconSize: 85,
                  color: Colors.blue,
                  onPressed: () {
                    print('Camera');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return CameraPart();
                      }),
                    );
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CameraButton()));
                  })),

          ///Opens Converter
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                padding: EdgeInsets.symmetric(horizontal: 65, vertical: 100),
                icon: Icon(Icons.insert_drive_file),
                iconSize: 85,
                color: Colors.blue,
                onPressed: () {
                  print('Camera');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Gallery();
                  }));
                  //Nav
                }),
          ),

          ///OPens Gallery
          Align(
            alignment: Alignment.bottomCenter,
            child: IconButton(
                padding: EdgeInsets.symmetric(horizontal: 65, vertical: 100),
                icon: Icon(Icons.insert_drive_file),
                iconSize: 85,
                color: Colors.blue,
                onPressed: () {
                  print('Camera');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Turner();
                  }));
                  //Nav
                }),
          ),

          ///opens tips page
          Align(
              alignment: Alignment.topRight,
              child: RaisedButton(
                  child: Text("help"),
                  color: Colors.blue,
                  onPressed: () {
                    print('going back');
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => new Faq()));
                  })),

          ///opens temp settings page
          Align(
              //Creates a new widget in the left part of the screen
              alignment: Alignment.topLeft,
              child: RaisedButton(
                  //Its a button that says back
                  child: Text("Settings"),
                  color: Colors.blue,
                  onPressed: () {
                    print('going back');
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                new Settings() //Will change to the setting page
                            ));
                  }))
        ],
      ),
    );
  }
}
