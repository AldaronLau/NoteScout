import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:note_scout/gallery.dart';
import 'package:note_scout/camera.dart';

void main() => runApp(MaterialApp(
    home: upload()
));

class upload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notescout"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
          margin: EdgeInsets.all(30.0),
          color: Colors.grey[400],


        ),
        floatingActionButton: RaisedButton(
            child: Text("Upload"),
            color: Color.fromARGB(0xFF, 0x00, 0xc8, 0xff),
            onPressed: () {
              print('Uploading');

              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new UplUD()
                  ));
            }
        )
    );
  }
}

class  UplUD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose and Upload option"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[

          Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 100),
                  icon: Icon(Icons.camera),
                  iconSize: 85,
                  color: Color.fromARGB(0xFF, 0x00, 0xc8, 0xff),
                  onPressed: () {
                    print('Camera');
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CameraButton()));
                  }
              )
          ),

          Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 100),
                  icon: Icon(Icons.insert_drive_file),
                  iconSize: 85,
                  color: Color.fromARGB(0xFF, 0x00, 0xc8, 0xff),
                  onPressed: () {
                    print('Camera');
                 // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Homepage()));
                  }
              )
          ),
          
          Align(
              alignment: Alignment.topRight,
              child: RaisedButton(
                  child: Text("help"),
                  color: Color.fromARGB(0xFF, 0x00, 0xc8, 0xff),
                  onPressed: () {
                    print('going back');
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => new stopitGetHelp()
                        ));
                  }
              )

          ),

        ],
      ),

    );
  }
}


class stopitGetHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
        centerTitle: true,
      ),
      body: Stack(
          children: <Widget>[

            Align(
              alignment: Alignment.center,
              child: Text("Upload a note: Open the camera button and take a picture of the note, to upoad it to the screen. If you have the note aready in your canera roll sellect gallery \n\n"
                  "View notes by going to the view menu and click view, to see all the notes you have \n\n"
                  "Use the search bar to look at all notes that have been uploaded\n\n"
                  "Press the bookmark to see any notes that you found interesting and have saved\n\n"
                  "If you have any more questions contact us at\n\n"
                  " Olderrm@augsburg.edu, Mengl@augsburg.edu, or at Lauj@augsburg.edu\n\n "
              )
              ),


          ]
      ),
    );
  }
}
