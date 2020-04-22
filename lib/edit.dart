import 'package:flutter/material.dart';

class EditNotePage extends StatefulWidget {
  EditNotePage({Key key}): super(key: key);

  @override
  EditNotePageState createState() => EditNotePageState();
}

class EditNotePageState extends State<EditNotePage> {
  var text_controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    text_controller = TextEditingController(text: "Placeholder note text");
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
      ),
      body: TextField(
        controller: text_controller,
        maxLines: null,
        minLines: 256,
      ),
    );
  }
}
