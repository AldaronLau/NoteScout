import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:note_scout/mynotes.dart';
import 'package:note_scout/view.dart';
import 'package:note_scout/uploader.dart';
import 'package:note_scout/merge.dart';
import 'package:note_scout/edit.dart';
import 'package:note_scout/main.dart';

class FolderPage extends StatefulWidget {
  MyNotesMode mode;
  List<String> files = [];
  String path;

  FolderPage({Key key, this.mode, this.files, this.path}) : super(key: key);

  @override
  FolderPageState createState() => new FolderPageState();
}

class FolderPageState extends State<FolderPage> {
  bool foldersInsteadOfTags = true;
  int rating = 0;
  double community_rating = 3.5;
  String notification = null;

  // Load a note's contents.
  Future noteContents(int index, bool bookmarked, ViewNoteMode mode) async {
    String fileString = USERNAME + "/" + widget.path + "/" + widget.files[index];
    try {
      await http
          .post(SERVER + "/viewit", body: fileString)
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
                if (resp.body.startsWith("SUCCESS")) {
                   setState(() {
                    print(resp.body);
                    var content = resp.body.split("\t")[1];
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                            return ViewNotePage(
                              mode: mode,
                              bookmarked: bookmarked,
                              content: content,
                              name: widget.files[index]
                            );
                        }),
                    );
                   });
                } else {
                  Fluttertoast.showToast(
                    msg: "WHOOPS!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: APPCOLOR,
                    textColor: Colors.black,
                    fontSize: 16.0);
                }
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

  // Loading folder list callback.  After last post, returns null.
  Widget loadFolder(BuildContext context, int index) {
    if (index >= widget.files.length) {
      return null;
    }

    String name = widget.files[index];

    IconData icon = Icons.note;

    return GestureDetector(
      onTap: () async {
        ViewNoteMode mode;
        bool bookmarked;
        if (widget.mode == MyNotesMode.Owned) {
          mode = ViewNoteMode.Owned;
          bookmarked = false;
        } else {
          mode = ViewNoteMode.Browsing;
          bookmarked = true;
        }

        await noteContents(index, bookmarked, mode);
      },
      child: Column(children: [
        Container(
          height: 50,
          color: Colors.transparent,
          child: Row(children: [
            Icon(icon),
            Text(name),
          ]),
        ),
        Divider()
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    assert(widget.mode != null);
    notification = null;
  }

  @override
  Widget build(BuildContext context) {
    List<String> menu_options = ["Sort By Tag", "Sort By Folder"];

    String title;
    List<Widget> actions = [];

    if (widget.mode == MyNotesMode.Owned) {
      title = "My Notes";
      menu_options.add("New Note");
      menu_options.add("Upload Note");

      actions.add(IconButton(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return EditNotePage(
                name: "New Note"
              );
            }),
          );
        },
        icon: Icon(Icons.note_add),
      ));
      actions.add(IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return upload();
            }),
          );
        },
        icon: Icon(Icons.file_upload),
      ));
      actions.add(
        PopupMenuButton<String>(onSelected: (String choice) {
          switch (choice) {
            case "Rename Folder...":
              showDialog(
                context: context,
                builder: (_) => RenameFolder(),
              );
              break;
            case "Merge Notes In Folder":
              showDialog(
                context: context,
                builder: (_) => MergeNotes(),
              );
              break;
            default:
              break;
          }
        }, itemBuilder: (BuildContext context) {
          return ["Rename Folder...", "Merge Notes In Folder"]
              .map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        }),
      );
    } else {
      title = "Bookmarks";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: loadFolder,
      ),
    );
  }
}

class RenameFolder extends StatefulWidget {
  RenameFolder({Key key}) : super(key: key);

  @override
  RenameFolderState createState() {
    return new RenameFolderState();
  }
}

class RenameFolderState extends State<RenameFolder> {
  TextEditingController text_controller;

  @override
  void initState() {
    super.initState();
    text_controller = TextEditingController(
      text: "Untitled Note",
    );
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text('Rename Folder'),
      content: TextField(
          controller: text_controller,
          toolbarOptions: ToolbarOptions(
              copy: false, cut: false, paste: false, selectAll: false),
          autofocus: true),
      actions: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Rename"),
          ),
        ]),
      ],
    );
  }
}
