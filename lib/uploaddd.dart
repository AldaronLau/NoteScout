import 'package:flutter/material.dart';
import 'package:note_scout/camera.dart';
import 'package:note_scout/converter.dart';
import 'package:note_scout/gallery.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
//import 'package:phoneapp/Selector.dart';
//import 'Camera.dart';
import 'package:note_scout/permission.dart';




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
                  }
              )
          ),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return MyHomePage();
                        }
                        )
                    );
                    //Nav
                  }
                  ),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Turner();
                      }
                      )
                  );
                  //Nav
                }
            ),
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
                        new MaterialPageRoute(builder: (context) => new stopitGetHelp()
                        ));
                  }
              )

          ),
///opens temp settings page
          Align( //Creates a new widget in the left part of the screen
              alignment: Alignment.topLeft,
              child: RaisedButton( //Its a button that says back
                  child: Text("Settings"),
                  color: Colors.blue,
                  onPressed: () {
                    print('going back');
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => new Settinf() //Will change to the setting page
                        ));
                  }
              )

          )


        ],
      ),

    );
  }
}

///FQA answers page
class stopitGetHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frequently Asked Questions"),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Stack(
          children: <Widget>[

            Align(
                alignment: Alignment.center,
                child: Text("Questions: How do I upload a note? \n\n"
                    "Answers: Open the camera button and take a picture of the note, to upload it to the screen. If you have the note aready in your canera roll sellect gallery \n\n"
                    "Question: How do I view my notes? \n\n"
                    "Answer: View notes by going to the view menu and click view, to see all the notes you have \n\n"
                    "Questions: How do I search my notes? \n\n"
                    "Answer: Use the search bar to look at all notes that have been uploaded\n\n"
                    "Question: How do I find my bookmarked notes? \n\n"
                    "Answer: Press the bookmark to see any notes that you found interesting and have saved\n\n"
                    "If you have any more questions contact us at\n\n"
                    "Olderrm@augsburg.edu, Mengl@augsburg.edu, Leek7@augsburg.edu or at Lauj@augsburg.edu\n\n "
                )
            ),


          ]
      ),
    );
  }
}
///Temporary setting page
class Settinf extends StatelessWidget {// Creates an page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),// Button that its called
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
          children: <Widget>[

            Align(
                alignment: Alignment.center, //Where the text is going to appear
                child: Text(" Tunr on Auto download?\n\n "
                    "Turn on scheduled trash?\n\n "
                )
            ),


          ]
      ),
    );
  }
}