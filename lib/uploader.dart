import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_scout/camera.dart';
import 'package:note_scout/converter.dart';
import 'package:note_scout/gallery.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
//import 'package:phoneapp/Selector.dart';
//import 'Camera.dart';
import 'package:note_scout/permission.dart';


import 'package:fluttertoast/fluttertoast.dart';
import 'package:note_scout/main.dart';
import 'package:http/http.dart' as http;


// update or create a note on server (format: "folder_name/picture_name").
// content is base64 string of picture.
Future savePictureNote(String filename, String content) async {
    String fileString = USERNAME
        + "\n"
        + PASSWORD
        + "\n"
        + filename
        + "\n"
        + content;
    try {
      await http
          .post(SERVER + "/modify", body: fileString)
          .timeout(const Duration(milliseconds: 5000))
          .then((resp) {
            print("Body: \" " + resp.body + "\"");
            switch (resp.body) {
              case "MALFORM": // Post Request Is Malformed
                Fluttertoast.showToast(
                    msg: "INTERNAL ERROR: REQUEST MALFORMED!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: APPCOLOR,
                    textColor: Colors.black,
                    fontSize: 16.0);
                break;
              case "SUCCESS": // Log In Succeeded
                Fluttertoast.showToast(
                    msg: "Saved!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: APPCOLOR,
                    textColor: Colors.black,
                    fontSize: 16.0);
                break;
              case "INVALID": // Invalid Username Password Combination
                Fluttertoast.showToast(
                    msg: "INTERNAL ERROR: WRONG PASSWORD!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: APPCOLOR,
                    textColor: Colors.black,
                    fontSize: 16.0);
                break;
              case "MISSING": // User is Missing From Database
                Fluttertoast.showToast(
                    msg: "INTERNAL ERROR: USER " + USERNAME + " DOESN'T EXIST!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: APPCOLOR,
                    textColor: Colors.black,
                    fontSize: 16.0);
                break;
              case "FAILURE": // Failed to connect to database":
                Fluttertoast.showToast(
                    msg: "INTERNAL ERROR: THE SERVER HAS A BUG!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: APPCOLOR,
                    textColor: Colors.black,
                    fontSize: 16.0);
                break;
              default:
                Fluttertoast.showToast(
                    msg: "WHOOPS!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: APPCOLOR,
                    textColor: Colors.black,
                    fontSize: 16.0);
                break;
            }
          });
        } catch (e) {
          print(e);
          Fluttertoast.showToast(
              msg: "CAN'T REACH SERVER!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: APPCOLOR,
              textColor: Colors.black,
              fontSize: 16.0);
        }
}




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
                        return Perpart();
                      }),
                    );
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CameraButton()));
                  }
              )
          ),
///Opens Converter
          ///


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
                          return Gallery();
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
                  child: Text("Permissions"),
                  color: Colors.blue,
                  onPressed: () {
                    print('Permissions');
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => new Perpart() //Will change to the setting page
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
            Align(
                alignment: Alignment.topLeft,
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
        title: Text("Permission"),// Button that its called
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
          children: <Widget>[

            Align(
                alignment: Alignment.center, //Where the text is going to appear
               child: MaterialButton(
    color: Colors.blue,
    child: Text('Permission'),
    onPressed: () {
      print('Permissions');
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new Perpart() //Will change to the setting page
          ));
    })
            ),

          ]
      ),
    );
  }
}
