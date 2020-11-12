import 'package:flutter/material.dart';
import 'package:note_scout/welcome.dart';
import 'package:note_scout/permission.dart';
import 'package:note_scout/signup.dart';

void main() => runApp(MyApp());

// The widget that contains the whole app.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "NoteScout",
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color.fromARGB(0xFF, 0x00, 0xc8, 0xff),
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage()
      },
      home: new Welcome(),
    );
  }
}
