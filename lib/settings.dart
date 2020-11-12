import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:note_scout/main.dart';

/// Settings page
class Settings extends StatelessWidget {
  // Creates an page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"), // Button that its called
        centerTitle: true,
        backgroundColor: APPCOLOR,
      ),
      body: Stack(children: <Widget>[
        Align(
            alignment: Alignment.center, //Where the text is going to appear
            child: Text("Turn on Auto download?\n\n"
                "Turn on scheduled trash?\n\n ")),
      ]),
    );
  }
}
