import 'package:flutter/material.dart';

import 'package:note_scout/mynotes.dart';
import 'package:note_scout/homepage.dart';

void main() => runApp(MaterialApp(
    title: "Note Scout",
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color.fromARGB(0xFF, 0x00, 0xc8, 0xff),
    ),
    home: MyApp()
));
