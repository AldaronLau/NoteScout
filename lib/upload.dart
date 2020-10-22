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

/**
 * Code for the Get Help page
 */
class stopitGetHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Frequently Asked Questions"),
        centerTitle: true,
      ),
      body: Stack(
          children: <Widget>[

            Align(
              alignment: Alignment.center,
              child: Text("Question: How do I create a note? \n\n"
                  "Answer: At the Homepage, top right corner has an icon. Click on the icon to create your note \n\n"
                  "Question: How do I view my notes?\n\n"
                  "Answer: View notes by going to the view menu and click view, to see all the notes you have \n\n"
                  "Question: How do I find my notes? \n\n"
                  "Answer: Use the search bar to look at all notes that have been uploaded\n\n"
                  "Question: How do I check my bookmarked notes? \n\n"
                  "Answer: Press the bookmark to see any notes that you found interesting and have saved\n\n"
                  "If you have any more questions, please contact our support team!\n\n"
                  "Olderrm@augsburg.edu, Mengl@augsburg.edu, Leekk7@augsburg.edu or at Lauj@augsburg.edu\n\n "
              )
              ),


          ]
      ),
    );
  }
}
