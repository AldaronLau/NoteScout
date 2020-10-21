import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:note_scout/forgotpassword.dart';
import 'package:note_scout/newNotes.dart';
import 'package:note_scout/sidemenu.dart';
import 'package:note_scout/searchnotes.dart';
import 'package:note_scout/view.dart';
import 'package:note_scout/newNotes.dart';
import 'package:note_scout/uploaddd.dart';
import 'package:note_scout/mynotes.dart';
import 'package:note_scout/signuppage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "NoteScout",
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color.fromARGB(0xFF, 0x00, 0xc8, 0xff),
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage()
      },
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

/**
 * log in/welcome page here
 */
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Welcome to',
                        style: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 175.0, 0.0, 0.0),
                    child: Text('NoteScout',
                        style: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(240.0, 175.0, 0.0, 0.0),
                    child: Text('!',
                        style: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue))),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue))),
                      obscureText: true,
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (context) => forgotPassword()));
                        },
                        child: Text(
                          'Forgot Password', //forgot password
                          style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) => GridLayout()));
                          },
                          child: Container(
                            height: 40.0,
                            child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Color.fromARGB(0xFF, 0x00, 0xc8, 0xff),
                                child: Center(
                                    child: Text('Log In',
                                      style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) => GridLayout()));
                          },
                          child: Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: 10.0),
                                Center(
                                  child: Text('Log in with Google',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat')),
                                )
                              ]),
                        ),
                      ),
                    )
                  ],
                )),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to NoteScout?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ));
  }
}

/**
 * grid layout homepage
 */
void mainn() => runApp(MaterialApp(home: GridLayout()));

class GridLayout extends StatelessWidget {
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
            margin: const EdgeInsets.only(top: 16.0), //SHIFTING THE GRID UPWARDS!!!!!!
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
                    switch(title) {
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
                                    return ViewNotePage(mode: ViewNoteMode.Owned);
                                }),
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                    return newnote();
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
                            Navigator.push(context,
                                new MaterialPageRoute(builder: (context) => new stopitGetHelp()
                            ));
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

/**
 * attribute to the icon authors
 */
// search notes icon <div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
// create new notes Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
// upload icon <div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
//my notes <div>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>
// get help Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
// favorite iconIcons made by <a href="https://www.flaticon.com/authors/those-icons" title="Those Icons">Those Icons</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
/**
 * side menu
 */
class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SideMenu();
  }
}

/**
 * search page filter chips
 */
Container myChips(String chipName) {
  return Container(
    child: RaisedButton(
        color: Colors.transparent,
        child: Text(chipName,
          style:TextStyle(
            //color: new Color(0xff6200ee),
          ),),
        onPressed: () {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                30.0))
    ),
  );
}
