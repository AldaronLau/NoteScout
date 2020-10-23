import 'package:flutter/material.dart';

import 'package:note_scout/edit.dart';

class newnote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Note"),
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: Container(
          child: Image.network("http://images.freeimages.com/images/previews/bf6/note-paper-1155539.jpg"),
          //padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
          //margin: EdgeInsets.all(30.0),
          //color: Colors.grey[400],


        ),


        floatingActionButton: RaisedButton(
            child: Text("Create Note"),
            color: Colors.blue,
            onPressed: () {
              print('making new note');

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return EditNotePage();
                }),
              );
            })
    );
  }
}