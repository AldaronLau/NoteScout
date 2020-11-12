import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:note_scout/home.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController username_controller;
  TextEditingController email_controller;
  TextEditingController password_controller;

  @override
  void initState() {
    super.initState();
    username_controller = TextEditingController();
    email_controller = TextEditingController();
    password_controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: true,
        body: ListView(children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 0.0),
                  child: Text(
                    'Create Your Account',
                    style:
                        TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(
                  top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
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
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: email_controller,
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: password_controller,
                    decoration: InputDecoration(
                        labelText: 'PASSWORD ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue))),
                    obscureText: true,
                  ),
                  SizedBox(height: 40.0),
                  Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.blueAccent,
                        color: Color.fromARGB(0xFF, 0x00, 0xc8, 0xff),
                        elevation: 1.0,
                        child: GestureDetector(
                          onTap: () async {
                            var user = username_controller.text;
                            var mail = email_controller.text;
                            var pswd = password_controller.text;
                            print("SIGNUP Username: " +
                                user +
                                ", Email: " +
                                mail +
                                ", Password: " +
                                pswd);

                            try {
                              await http
                                  .post('http://10.0.0.90:8000/signup',
                                      body: user + "\n" + mail + "\n" + pswd)
                                  .then((resp) {
                                print("Body: \"" + resp.body + "\"");
                                switch (resp.body) {
                                  case "MALFORM": // Post Request Is Malformed
                                    Fluttertoast.showToast(
                                        msg: "App couldn't sign up - outdated?",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Color.fromARGB(
                                            0xFF, 0x00, 0xc8, 0xff),
                                        textColor: Colors.black,
                                        fontSize: 16.0);
                                    break;
                                  case "SUCCESS": // Log In Succeeded
                                    Fluttertoast.showToast(
                                        msg: "Account successfully created!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Color.fromARGB(
                                            0xFF, 0x00, 0xc8, 0xff),
                                        textColor: Colors.black,
                                        fontSize: 16.0);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute<void>(
                                            builder: (context) => Home()));
                                    break;
                                  case "INVALID": // Username Taken
                                    Fluttertoast.showToast(
                                        msg: "Username Unavailable!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Color.fromARGB(
                                            0xFF, 0x00, 0xc8, 0xff),
                                        textColor: Colors.black,
                                        fontSize: 16.0);
                                    break;
                                  case "FAILURE": // Failed to connect to database":
                                    Fluttertoast.showToast(
                                        msg: "The server has a bug!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Color.fromARGB(
                                            0xFF, 0x00, 0xc8, 0xff),
                                        textColor: Colors.black,
                                        fontSize: 16.0);
                                    break;
                                  default:
                                    Fluttertoast.showToast(
                                        msg: "Whoops!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Color.fromARGB(
                                            0xFF, 0x00, 0xc8, 0xff),
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
                                  backgroundColor:
                                      Color.fromARGB(0xFF, 0x00, 0xc8, 0xff),
                                  textColor: Colors.black,
                                  fontSize: 16.0);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (context) => Home()));
                            }
                          },
                          child: Center(
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.blueAccent,
                      color: Color.fromARGB(0xFF, 0x00, 0xc8, 0xff),
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Text(
                            'Sign Up with Google',
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
                  Container(
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
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Center(
                          child: Text('Go Back',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat')),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ]));
  }
}
