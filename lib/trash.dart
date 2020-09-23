import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MaterialApp(
    home: trash()
));

class trash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trash"),
        centerTitle: true,
      ),
      body: Stack(
          children: <Widget>[

            Align(
                alignment: Alignment.center,
                child: Text("This is the trash for your unwanted notes"
                )
            ),


          ]
      ),
    );
  }
}