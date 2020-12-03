import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:note_scout/home.dart';
import 'package:note_scout/forgotpassword.dart';
import 'package:note_scout/main.dart';

class Welcome extends StatefulWidget {
  @override
  WelcomeState createState() => new WelcomeState();
}

/**
 * Log in page here
 */
class WelcomeState extends State<Welcome> {
  TextEditingController username_controller;
  TextEditingController password_controller;

  @override
  void initState() {
    super.initState();
    username_controller = TextEditingController();
    password_controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: true,
        body: ListView(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 0.0),
                    child: Text('Welcome to NoteScout!',
                        style: TextStyle(
                            fontSize: 45.0, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: username_controller,
                      decoration: InputDecoration(
                          labelText: 'USERNAME',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue))),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: password_controller,
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
                              color: APPCOLOR,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    GestureDetector(
                      onTap: () async {
                        var user = username_controller.text;
                        var pswd = password_controller.text;
                        USERNAME = user;
                        PASSWORD = pswd;
                        print(
                            "LOGIN Username: " + user + ", Password: " + pswd);

                        try {
                          await http
                              .post(SERVER + "/log_in",
                                  body: user + "\n" + pswd)
                              .timeout(const Duration(milliseconds: 5000))
                              .then((resp) {
                            print("Body: \"" + resp.body + "\"");
                            switch (resp.body) {
                              case "MALFORM": // Post Request Is Malformed
                                Fluttertoast.showToast(
                                    msg: "You must provide a password!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: APPCOLOR,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                                break;
                              case "SUCCESS": // Log In Succeeded
                                Fluttertoast.showToast(
                                    msg: "Logged in successfully!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: APPCOLOR,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                                // Use App Online
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (context) => Home()));
                                break;
                              case "INVALID": // Invalid Username Password Combination
                                Fluttertoast.showToast(
                                    msg: "Your password is wrong!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: APPCOLOR,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                                break;
                              case "MISSING": // User is Missing From Database
                                Fluttertoast.showToast(
                                    msg: "User " + user + " doesn't exist!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: APPCOLOR,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                                break;
                              case "FAILURE": // Failed to connect to database":
                                Fluttertoast.showToast(
                                    msg: "The server has a bug!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: APPCOLOR,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                                break;
                              default:
                                Fluttertoast.showToast(
                                    msg: "Whoops!",
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
                              msg: "Offline!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: APPCOLOR,
                              textColor: Colors.black,
                              fontSize: 16.0);
                          // Launch app in offline mode.
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (context) => Home()));
                        }
                      },
                      child: Container(
                        height: 40.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: APPCOLOR,
                          child: Center(
                            child: Text(
                              'Log In',
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
                                builder: (context) => Home()));
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
            SizedBox(height: 20.0),
            Container(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Row(
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
                            color: APPCOLOR,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
