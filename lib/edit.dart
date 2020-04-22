import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    text_controller = TextEditingController(
        text: "Placeholder note text",
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
        actions: <Widget>[
            IconButton(
                icon: Icon(Icons.select_all),
                onPressed: () {
                    text_controller.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: text_controller.text.length,
                    );
                }
            ),
          IconButton(
              icon: Icon(Icons.content_cut),
              onPressed: () {
                int start = text_controller.selection.baseOffset;

                Clipboard.setData(ClipboardData(text: text_controller.text.substring(start, text_controller.selection.extentOffset)));
                text_controller.text = text_controller.text.substring(0, start) + text_controller.text.substring(text_controller.selection.extentOffset, text_controller.text.length);

                text_controller.selection = TextSelection.collapsed(offset: start);
              }),
          IconButton(
              icon: Icon(Icons.content_copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: text_controller.text.substring(text_controller.selection.baseOffset, text_controller.selection.extentOffset)));
              }),
          IconButton(
              icon: Icon(Icons.content_paste),
              onPressed: () {
                int start = text_controller.selection.baseOffset;
                int end = text_controller.selection.extentOffset;

                Clipboard.getData("text/plain").then((clip) {
                    String new_text = clip.text;

                    int new_end = end + new_text.length - (end - start);

                    text_controller.text = text_controller.text.substring(0, start) + new_text + text_controller.text.substring(end, text_controller.text.length);

                    text_controller.selection = TextSelection.collapsed(offset: new_end);
                });
              }),
        ],
      ),
      body: TextField(
        controller: text_controller,
        toolbarOptions: ToolbarOptions(
            copy: false, cut: false, paste: false, selectAll: false
        ),
        autofocus: true,
        maxLines: null,
        minLines: null,
        expands: true,
      ),
    );
  }
}
