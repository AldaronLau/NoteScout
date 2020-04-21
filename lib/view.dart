import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';

import 'package:note_scout/edit.dart';

class ViewNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Note"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.blue,
        child: Image.network("http://images.freeimages.com/images/previews/bf6/note-paper-1155539.jpg"),

      ),
      floatingActionButton: RaisedButton(
        child: Icon(Icons.edit),
        color: Colors.blue,
        onPressed: () {
          // Switch to edit screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditNote()),
          );
        },
      ),
    );
  }
}
