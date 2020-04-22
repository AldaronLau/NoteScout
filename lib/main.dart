import 'package:flutter/material.dart';

import 'package:note_scout/edit.dart';
import 'package:note_scout/load.dart';
import 'package:note_scout/view.dart';
import 'package:note_scout/loginscreen.dart';

void main() => runApp(MaterialApp(
    title: "Note Scout",
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color.fromARGB(0xFF, 0x00, 0xc8, 0xff),
    ),
    home: ViewNotePage() // LoginScreen()
));
