import 'package:flutter/material.dart';
import 'package:note_scout/welcome.dart';
import 'package:note_scout/permission.dart';
import 'package:note_scout/signup.dart';

const SERVER = "http://73.94.232.74:9000";
// const SERVER = "http://10.0.0.90:9000";

const APPCOLOR = Color.fromARGB(0xFF, 0x00, 0xc8, 0xff);

String USERNAME = null;
String PASSWORD = null;

void main() => runApp(MyApp());

// The widget that contains the whole app.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "NoteScout",
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: APPCOLOR,
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage()
      },
      home: new Welcome(),
    );
  }
}
