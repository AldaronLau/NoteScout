import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:note_scout/main.dart';

/// Settings page
class myaccount extends StatelessWidget {
  // Creates an page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"), // Button that its called
        centerTitle: true,
        backgroundColor: APPCOLOR,
      ),
      body: Stack(children: <Widget>[
        Align(
            alignment: Alignment.centerLeft, //Where the text is going to appear
            //child: Text(("Image from assets"),

            child: Image.asset('assets/user.png'), //   <-- image
      )],
      ));
  }
}



//https://www.flaticon.com/free-icon/user_1946429?term=avatar&page=1&position=25&related_item_id=1946429