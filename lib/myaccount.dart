import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:note_scout/main.dart';

/// Settings page
class myaccount extends StatelessWidget {
  // Creates an page
  @override

  @override
  Widget build(BuildContext context) {
/*
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          title: Text('Insert Image Demo'),
        ),

        body: Center(
          child: Column(
            children: <Widget>[
              Image.asset('assets/user.png'),
            ],
          ),
        ),
      ),
    );
  }
}*/
 // Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"), // Button that its called
        centerTitle: true,
        backgroundColor: APPCOLOR,
      ),
      body: Stack(children: <Widget>[
      //body: Stack(children: <Widget>[
      Align(
      alignment: Alignment.topRight, //Where the text is going to appear
          child: Text(
              "\n\n"
              "\n\n"
              "Username: _________________\n\n" "\n\n"
              "Email: _____________________\n\n" "\n\n"
              "Password: _________________\n\n ")),




/*
        Align(
            alignment: Alignment.centerLeft, //Where the text is going to appear
            child: Text(

                "\n\n"
                    "\n\n"
                    "Username: ________________\n\n" "\n\n"
                    "Email: ____________________\n\n" "\n\n"
                    "Password: ________________\n\n ")),*/
        Container(
        height: 175.0,
        width: 175.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/user.png'
            ),
            fit: BoxFit.fill,

          ),
         // shape: BoxShape.circle,
        ),
      )

        /*Align(
            alignment: Alignment.centerLeft, //Where the text is going to appear
            //child: Text(("Image from assets"),

            child: Image.asset('assets/user.png')*/, //   <-- image
      ],
      ));
  }
}



//https://www.flaticon.com/free-icon/user_1946429?term=avatar&page=1&position=25&related_item_id=1946429