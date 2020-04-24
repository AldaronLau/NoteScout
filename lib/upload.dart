import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';


void main() => runApp(MaterialApp(
    home: upload()
));


class upload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("NoteScout"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Container(
          color: Colors.blue,
          child: Image.network(
              "http://images.freeimages.com/images/previews/bf6/note-paper-1155539.jpg"),

        ),
        floatingActionButton: RaisedButton(
            child: Text("Uplpoad"),
            color: Colors.blue,
            onPressed: () {
              print('Uploading');

              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new UplUD()
                  ));
            }
        )
    );
  }
}

class  UplUD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose and Upload option"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
          children: <Widget>[
      Align(
      alignment: Alignment.bottomLeft,
          child: RaisedButton(
              child: Text("camera"),
              color: Colors.blue,
              onPressed: () {
                print('Camera');
              }
          )
      ),
      Align(
          alignment: Alignment.bottomRight,
          child: RaisedButton(
              child: Text("Gallery"),
              color: Colors.blue,
              onPressed: () {
                print('Seeing');
              }
          )

      ),
            Align(
                alignment: Alignment.topLeft,
                child: RaisedButton(
                    child: Text("back"),
                    color: Colors.blue,
                    onPressed: () {
                      print('going back');
                    Navigator.pop(context);
                    }
                )

            ),
      ],
    ),

    );
  }
}
