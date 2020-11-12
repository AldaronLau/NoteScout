import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:note_scout/permission.dart';
import 'package:note_scout/forgotpassword.dart';
import 'package:note_scout/sidemenu.dart';
import 'package:note_scout/searchnotes.dart';
import 'package:note_scout/view.dart';
import 'package:note_scout/edit.dart';
import 'package:note_scout/upload.dart';
import 'package:note_scout/faq.dart';
import 'package:note_scout/mynotes.dart';
import 'package:note_scout/signup.dart';
import 'package:note_scout/welcome.dart';

void main() => runApp(MaterialApp(home: Home()));

/**
 * Home page with grid layout
 */
class Home extends StatelessWidget {
  List<String> events = [
    "Search Notes",
    "Create New Notes",
    "Upload",
    "My Notes",
    "Bookmarks",
    "Get Help",
  ];

  @override
  Widget build(BuildContext context) {
    // creating empty app with background
    return Scaffold(
        appBar: AppBar(title: Text("NoteScout")),
        drawer: Drawer(child: SideMenu()),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.png"), fit: BoxFit.cover),
          ),
          child: Container(
            margin: const EdgeInsets.only(
                top: 16.0), //SHIFTING THE GRID UPWARDS!!!!!!
            child: GridView(
              physics: BouncingScrollPhysics(), // only for iOS
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: events.map((title) {
                //loop all item in events list
                return GestureDetector(
                  child: Card(
                    margin: const EdgeInsets.all(20.0),
                    child: getCardByTitle(title),
                  ),
                  onTap: () {
                    //show toast
                    Fluttertoast.showToast(
                        msg: title + " click",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Color.fromARGB(0xFF, 0x00, 0xc8, 0xff),
                        textColor: Colors.black,
                        fontSize: 16.0);

                    // Change page
                    switch (title) {
                      case "Search Notes":
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return searchNotes();
                          }),
                        );
                        break;
                      case "Create New Notes":
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return EditNotePage();
                          }),
                        );
                        break;
                      case "Upload":
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return upload();
                          }),
                        );
                        break;
                      case "My Notes":
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return MyNotesPage(mode: MyNotesMode.Owned);
                          }),
                        );
                        break;
                      case "Bookmarks":
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return MyNotesPage(mode: MyNotesMode.Browsing);
                          }),
                        );
                        break;
                      case "Get Help":
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new Faq()));
                        break;
                      default:
                        break;
                    }
                  },
                );
              }).toList(),
            ),
          ),
        ));
  }

  /**
   * images for the grid icons
   * 
   * Attribute to the icon authors:
   * search notes icon <div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
   * create new notes Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
   * upload icon <div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
   * my notes <div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
   * get help Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
   * favorite iconIcons made by <a href="https://www.flaticon.com/authors/those-icons" title="Those Icons">Those Icons</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
   */
  Column getCardByTitle(String title) {
    String img = "";
    if (title == "Search Notes")
      img = "assets/search.png";
    else if (title == "Create New Notes")
      img = "assets/document.png";
    else if (title == "Upload")
      img = "assets/upload.png";
    else if (title == "My Notes")
      img = "assets/contract.png";
    else if (title == "Bookmarks")
      img = "assets/favorite.png";
    else if (title == "Get Help") img = "assets/info.png";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Center(
          child: Container(
            child: new Stack(
              children: <Widget>[
                new Image.asset(img, width: 80.0, height: 80.0)
              ],
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
