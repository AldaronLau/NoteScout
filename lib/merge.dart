import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MergeNotes extends StatefulWidget {
  MergeNotes({Key key}) : super(key: key);

  @override
  MergeNotesState createState() {
    return new MergeNotesState();
  }
}

class MergeNotesState extends State<MergeNotes> {
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: const Text('Merge All Notes In This Folder?'),
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
              Fluttertoast.showToast(
                  msg: "Notes Merged!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Color.fromARGB(0xFF, 0x00, 0xc8, 0xff),
                  textColor: Colors.black,
                  fontSize: 16.0);
            },
            child: Text("Merge Notes"),
          ),
        ]),
      ],
    );
  }
}
