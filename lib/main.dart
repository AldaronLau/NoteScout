import 'package:flutter/material.dart';
import 'package:note_scout/homepage.dart';
import 'package:note_scout/permission.dart';

void main() => runApp(MyApp());


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