import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:note_scout/main.dart';

// Move Note / Copy Note / Label Note

enum FolderMode {
  Copy,
  Move,
  Labels,
}

class SelectFolder extends StatefulWidget {
  FolderMode mode;

  SelectFolder({Key key, this.mode}) : super(key: key);

  @override
  SelectFolderState createState() => new SelectFolderState();
}

class SelectFolderState extends State<SelectFolder> {
  List<bool> using_label;

  // Loading folder list callback.  After last post, returns null.
  Widget loadFolder(BuildContext context, int index) {
    if (index >= 24) {
      return null;
    }

    String name;

    if (widget.mode != FolderMode.Labels) {
      name = " Folder #";
    } else {
      name = " Tag #";
    }

    IconData icon;
    String msg;

    if (widget.mode != FolderMode.Labels) {
      icon = Icons.folder;
      if (widget.mode == FolderMode.Copy) {
        msg = "Copied Note!";
      } else {
        msg = "Moved Note!";
      }
    } else {
      if (using_label[index]) {
        icon = Icons.label;
      } else {
        icon = Icons.label_outline;
      }
    }

    return GestureDetector(
      onTap: () {
        if (widget.mode != FolderMode.Labels) {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: APPCOLOR,
              textColor: Colors.black,
              fontSize: 16.0);
        } else {
          setState(() {
            using_label[index] = !using_label[index];
          });
        }
      },
      child: Column(children: [
        Container(
          height: 50,
          color: Colors.transparent,
          child: Row(children: [
            Icon(icon),
            Text('${name}${index + 1}'),
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
    using_label = [];
    for (int i = 0; i < 24; i++) {
      using_label.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    String title;
    if (widget.mode == FolderMode.Copy) {
      title = "Copy to where...?";
    } else if (widget.mode == FolderMode.Move) {
      title = "Move to where...?";
    } else {
      title = "Select Which Tags";
    }

    IconData adder;

    if (widget.mode != FolderMode.Labels) {
      adder = Icons.create_new_folder;
    } else {
      adder = Icons.add;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
              icon: Icon(adder),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) =>
                      Adder(isFolder: widget.mode != FolderMode.Labels),
                );
              })
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: loadFolder,
      ),
    );
  }
}

class Adder extends StatefulWidget {
  bool isFolder;

  Adder({Key key, this.isFolder}) : super(key: key);

  @override
  AdderState createState() {
    return new AdderState();
  }
}

class AdderState extends State<Adder> {
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
    String text;

    if (widget.isFolder) {
      text = "New Folder";
    } else {
      text = "New Tag";
    }

    return new AlertDialog(
      title: Text(text),
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
            child: Text("Create"),
          ),
        ]),
      ],
    );
  }
}
