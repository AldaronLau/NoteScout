import 'package:flutter/material.dart';

class EditNotePage extends StatefulWidget {
  EditNotePage({Key key}): super(key: key);

  @override
  EditNotePageState createState() => EditNotePageState();
}

class EditNotePageState extends State<EditNotePage> {
  String text = "";

  FocusNode focus;

  final text_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    focus = FocusNode();
    // node.addListener(handle_focus_change); FIXME
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
      ),
      body: EditableText(controller: text_controller, focusNode: focus,
                         style: DefaultTextStyle.of(context).style,
                         cursorColor: Color.fromARGB(255, 0, 0, 0),
                         backgroundCursorColor: Color.fromARGB(0, 0, 0, 0)),
    );
  }
}
