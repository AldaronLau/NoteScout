import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:note_scout/homepage.dart';
import 'dart:async';
///import 'package:note_scout/pdf_text.dart';


void Main() => runApp(Turner());

class Turner extends StatefulWidget {
  @override
  TurnerSS createState() => TurnerSS();

}

class TurnerSS extends State <Turner> {

  String _pdfDoc;
  String _words = "";

  bool _enable = true;

  @override
  void initstate() {
    super.initState();
  }
  /// Picks a PDF file from the device

  Future _PickaText() async {
    File file = await FilePicker.getFile();
    //_pdfDoc = await PDFDoc.fromFile(file);
    setState(() {

    });
  }

  /// the entire document get written
  Future _readAlltheDocs() async {
    if (_pdfDoc == null) {
      return;
    }
    setState(() {
      _enable = false;
    });
    ///String text = await _pdfDoc.text;

    setState(() {
  ///    _words = text;
      _enable = true;
    });
  }
///Construct the app window which the
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: const Text("Digital Note Converter")
          ),
          body: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(12),
              child: ListView(children: <Widget>[
                FlatButton(
                  child: Text(
                    "Pick a file",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blueAccent,
                  onPressed: _PickaText,
                  padding: EdgeInsets.all(6),

                ),

                FlatButton(
                  child: Text(
                    "Analyse the document",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blueAccent,
                  onPressed: _enable ? _readAlltheDocs : () {},
                  padding: EdgeInsets.all(6),
                ),
                Padding(

                  child: Text(
                    _pdfDoc == null

                        ? "Do something else while the text loads"
                        : "PDF document is loading ${_pdfDoc.length} pages \n",
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,

                  ),
                  padding: EdgeInsets.all(16),
                ),


                Padding(

                  child: Text(
                    _words == "" ? "" : "Texts:",
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(16),
                ),
                Text(_words),

              ],

              )
          )),
    );

  }

}
