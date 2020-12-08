import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'package:note_scout/view.dart';
import 'package:note_scout/edit.dart';
import 'package:note_scout/folder.dart';
import 'package:note_scout/uploader.dart';
import 'package:note_scout/main.dart';

enum MyNotesMode {
  // For notes not owned by the user
  Browsing,
  // For notes owned by the user.
  Owned,
}

// Page to list folders.
class MyNotesPage extends StatefulWidget {
  MyNotesMode mode;

  MyNotesPage({Key key, this.mode}) : super(key: key);

  @override
  MyNotesPageState createState() => new MyNotesPageState();
}

class MyNotesPageState extends State<MyNotesPage> {
  bool foldersInsteadOfTags = true;
  int rating = 0;
  double community_rating = 3.5;
  String notification = null;
  List<List<String>> files = [];
  List<String> folders = [];

  // Load list of notes an folders.
  Future myNotes() async {
    String fileString = USERNAME + "\n" + PASSWORD;
    try {
      await http
          .post(SERVER + "/listmy", body: fileString)
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
                   var file_list = resp.body.split('\n');
                   folders = [];
                   for(int i = 1; i < file_list.length; i++) {
                     if (file_list[i].length == 0) { break; } 
                     var splitted = file_list[i].split('/');
                     var folder = splitted[1];
                     var filename = splitted[2];
                     if (folder != "Trash") {
                         if (!folders.contains(folder)) {
                           folders.add(folder);
                           files.add([filename]);
                         } else {
                           files[folders.indexOf(folder)].add(filename);
                         }
                     }
                   } });
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
    if (index >= folders.length) {
      return null;
    }

    IconData icon;

    if (foldersInsteadOfTags) {
      icon = Icons.folder;
    } else {
      icon = Icons.label;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return FolderPage(mode: widget.mode, files: files[index], path: folders[index]);
          }),
        );
      },
      child: Column(children: [
        Container(
          height: 50,
          color: Colors.transparent,
          child: Row(children: [
            Icon(icon),
            Text(folders[index]),
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
    myNotes();
  }

  @override
  Widget build(BuildContext context) {
    List<String> menu_options = ["Sort By Tag", "Sort By Folder"];

    String title;

    if (widget.mode == MyNotesMode.Owned) {
      title = "My Notes";
      menu_options.add("New Note");
      menu_options.add("Upload Note");
    } else {
      title = "Bookmarks";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          PopupMenuButton<String>(onSelected: (String choice) {
            switch (choice) {
              case "Sort By Tag":
                setState(() {
                  foldersInsteadOfTags = false;
                });
                break;
              case "Sort By Folder":
                setState(() {
                  foldersInsteadOfTags = true;
                });
                break;
              case "New Note":
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ViewNotePage(mode: ViewNoteMode.Owned);
                  }),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return EditNotePage();
                  }),
                );
                break;
              case "Upload Note":
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return upload();
                  }),
                );
                break;
              default:
                assert(false);
            }
          }, itemBuilder: (BuildContext context) {
            return menu_options.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          }),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: loadFolder,
      ),
    );
  }
}
