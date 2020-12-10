import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'package:note_scout/view.dart';
import 'package:note_scout/main.dart';

class searchNotes extends StatefulWidget {
  @override
  _searchNotes createState() => _searchNotes();
}

/**
 * search notes page
 */
class _searchNotes extends State<searchNotes> {
  TextEditingController search_controller;
  
  List<String> files = [];

  @override
  void initState() {
    super.initState();
    search_controller = TextEditingController();
    search_controller.text = "";
    searchNotes(search_controller.text);
  }

  // Load list of notes an folders.
  Future searchNotes(String query) async {
    try {
      await http
          .post(SERVER + "/search", body: query)
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
                       files = [];
                       for(int i = 1; i < file_list.length; i++) {
                         if (file_list[i].length == 0) { break; } 
                         files.add(file_list[i]);
                       }
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

  // Load a note's contents from the full path USERNAME/FOLDER/NOTE.
  Future noteContents(String username, String folder, String note, bool bookmarked, ViewNoteMode mode) async {
    var fileString = username + "/" + folder + "/" + note;
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
                              name: note,
                              folder: folder,
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
  Widget foundNote(BuildContext context, int index) {
    if (index >= files.length) {
      return null;
    }

    IconData icon = Icons.note;

    return GestureDetector(
      onTap: () async {
        var splitted = files[index].split("/");
        var username = splitted[0];
        var folder = splitted[1];
        var notename = splitted[2];
      
        ViewNoteMode mode;
        bool bookmarked;
        if (username[0] == USERNAME) {
          mode = ViewNoteMode.Owned;
          var bookmarked = false;
        } else {
          mode = ViewNoteMode.Browsing;
          bookmarked = true;
        }

        await noteContents(username, folder, notename, bookmarked, mode);
      },
      child: Column(children: [
        Container(
          height: 50,
          color: Colors.transparent,
          child: Row(children: [
            Icon(icon),
            Text(files[index]),
          ]),
        ),
        Divider()
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text("Search Notes")),
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              onChanged: (text) {
                print("Searching: \"$text\"");
                searchNotes(text);
              },
              controller: search_controller,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                 borderSide: BorderSide(color: Colors.lightBlue))),
            ),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Filter By: ',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
            )),
            Row(
              children: <Widget>[
                myChips("Recntly Opened"),
                myChips("View Other User's Notes"),
              ],
            ),
            //chips
            Container(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: RaisedButton(
                  color: Colors.transparent,
                  child: Text(
                    " Recently Added ",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            new Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: foundNote,
                )
            )
          ],
        ));
  }
}

// Filter chip widgets
Container myChips(String chipName) {
  return Container(
    child: RaisedButton(
        color: Colors.transparent,
        child: Text(
          chipName,
          style: TextStyle(/*color: new Color(0xff6200ee)*/),
        ),
        onPressed: () {},
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
  );
}
