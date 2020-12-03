import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';

import 'package:note_scout/mynotes.dart';
import 'package:note_scout/view.dart';
import 'package:note_scout/upload.dart';
import 'package:note_scout/merge.dart';
import 'package:note_scout/edit.dart';

class FolderPage extends StatefulWidget {
  MyNotesMode mode;
  List<String> files = [];

  FolderPage({Key key, this.mode, this.files}) : super(key: key);

  @override
  FolderPageState createState() => new FolderPageState();
}

class FolderPageState extends State<FolderPage> {
  bool foldersInsteadOfTags = true;
  int rating = 0;
  double community_rating = 3.5;
  String notification = null;

  // Loading folder list callback.  After last post, returns null.
  Widget loadFolder(BuildContext context, int index) {
    if (index >= widget.files.length) {
      return null;
    }

    String name = widget.files[index];

    IconData icon = Icons.note;

    return GestureDetector(
      onTap: () {
        ViewNoteMode mode;
        bool bookmarked;
        if (widget.mode == MyNotesMode.Owned) {
          mode = ViewNoteMode.Owned;
          bookmarked = false;
        } else {
          mode = ViewNoteMode.Browsing;
          bookmarked = true;
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ViewNotePage(mode: mode, bookmarked: bookmarked);
          }),
        );
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
              return ViewNotePage(mode: ViewNoteMode.Owned);
            }),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return EditNotePage();
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
