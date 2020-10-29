import 'package:flutter/material.dart';
import 'package:note_scout/homepage.dart';
import 'package:note_scout/permission.dart';

void main() => runApp(MyApp());

///Pops up an acess button. Supposedly it should bring a popup asking for permission
class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Permission needed',
      theme: new ThemeData(primaryColor: Colors.blueAccent),
      home: new permission(),


    );


  }
}