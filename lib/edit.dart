import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'package:note_scout/view.dart';
import 'package:note_scout/main.dart';

class EditNotePage extends StatefulWidget {
  String text = "";

  EditNotePage({Key key, this.text}) : super(key: key);

  @override
  EditNotePageState createState() => EditNotePageState();
}

class EditNotePageState extends State<EditNotePage> {
  TextEditingController text_controller;
  bool selected;
  
  // Change note contents on server.
  Future saveNote(String filename, String content) async {
    String fileString = USERNAME
        + "\n"
        + PASSWORD
        + "\n"
        + filename
        + "\t"
        + content;
    try {
      await http
          .post(SERVER + "/modify", body: fileString)
          .timeout(const Duration(milliseconds: 5000))
          .then((resp) {
            print("Body: \"" + resp.body + "\"");
            switch (resp.body) {
              case "MALFORM": // Post Request Is Malformed
                Fluttertoast.showToast(
                    msg: "INTERNAL ERROR: REQUEST MALFORMED!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: APPCOLOR,
                    textColor: Colors.black,
                    fontSize: 16.0);
                break;
              case "SUCCESS": // Log In Succeeded
                Fluttertoast.showToast(
                    msg: "Saved!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: APPCOLOR,
                    textColor: Colors.black,
                    fontSize: 16.0);
                break;
              case "INVALID": // Invalid Username Password Combination
                Fluttertoast.showToast(
                    msg: "INTERNAL ERROR: WRONG PASSWORD!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: APPCOLOR,
                    textColor: Colors.black,
                    fontSize: 16.0);
                break;
              case "MISSING": // User is Missing From Database
                Fluttertoast.showToast(
                    msg: "INTERNAL ERROR: USER " + USERNAME + " DOESN'T EXIST!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: APPCOLOR,
                    textColor: Colors.black,
                    fontSize: 16.0);
                break;
              case "FAILURE": // Failed to connect to database":
                Fluttertoast.showToast(
                    msg: "INTERNAL ERROR: THE SERVER HAS A BUG!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: APPCOLOR,
                    textColor: Colors.black,
                    fontSize: 16.0);
                break;
              default:
                Fluttertoast.showToast(
                    msg: "WHOOPS!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: APPCOLOR,
                    textColor: Colors.black,
                    fontSize: 16.0);
                break;
            }
          });
        } catch (e) {
          print(e);
          Fluttertoast.showToast(
              msg: "CAN'T REACH SERVER!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: APPCOLOR,
              textColor: Colors.black,
              fontSize: 16.0);
        }
  }

  @override
  void initState() {
    super.initState();
    text_controller = TextEditingController();
    text_controller.text = widget.text;
    selected = false;
  }

  @override
  Widget build(BuildContext context) {
    text_controller.addListener(() {
      setState(() {
        selected = text_controller.selection.baseOffset !=
            text_controller.selection.extentOffset;
      });
    });

    List<Widget> actions = [];

    if (selected) {
      actions.add(IconButton(
          icon: Icon(Icons.content_cut),
          onPressed: () {
            int start = text_controller.selection.baseOffset;

            Clipboard.setData(ClipboardData(
                text: text_controller.text
                    .substring(start, text_controller.selection.extentOffset)));
            text_controller.text = text_controller.text.substring(0, start) +
                text_controller.text.substring(
                    text_controller.selection.extentOffset,
                    text_controller.text.length);

            text_controller.selection = TextSelection.collapsed(offset: start);
          }));
      actions.add(IconButton(
          icon: Icon(Icons.content_copy),
          onPressed: () {
            Clipboard.setData(ClipboardData(
                text: text_controller.text.substring(
                    text_controller.selection.baseOffset,
                    text_controller.selection.extentOffset)));
          }));
    } else {
      actions.add(IconButton(
          icon: Icon(Icons.undo),
          onPressed: () {
            print("FIXME: Undo");
          }));
      actions.add(IconButton(
          icon: Icon(Icons.redo),
          onPressed: () {
            print("FIXME: Redo");
          }));
    }

    actions.add(IconButton(
        icon: Icon(Icons.select_all),
        onPressed: () {
          text_controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: text_controller.text.length,
          );
        }));
    actions.add(IconButton(
        icon: Icon(Icons.content_paste),
        onPressed: () {
          int start = text_controller.selection.baseOffset;
          int end = text_controller.selection.extentOffset;

          Clipboard.getData("text/plain").then((clip) {
            String new_text = clip.text;

            int new_end = end + new_text.length - (end - start);

            text_controller.text = text_controller.text.substring(0, start) +
                new_text +
                text_controller.text
                    .substring(end, text_controller.text.length);

            text_controller.selection =
                TextSelection.collapsed(offset: new_end);
          });
        }));

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
        actions: actions,
      ),
      body: TextField(
        controller: text_controller,
        //This is to make sure the Area to type is the whole page
        autofocus: true,
        maxLines: null,
        minLines: null,
        expands: true,
        toolbarOptions: ToolbarOptions(
            copy: false, cut: false, paste: false, selectAll: false),
        decoration: InputDecoration(
          //prefixIcon: Icon(Icons.message),
          labelText: 'What would You like to note down?',
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Text("Done"),
          onPressed: () async {
            String content = text_controller.text;
            await saveNote("New Notes/New Note", content);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                    return ViewNotePage(
                      mode: ViewNoteMode.Owned,
                      content: content
                    );
                }),
            );
            /*var route = new MaterialPageRoute(
              builder: (BuildContext context) => new ViewNotePage(
                  mode: ViewNoteMode.Owned, content: content),
            );
            Navigator.of(context).push(route);*/
          }),
    );
  }
}
