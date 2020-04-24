import 'package:flutter/material.dart';
import 'package:note_scout/homepage.dart';

class searchNotes extends StatefulWidget {
  @override
  _searchNotes createState() => _searchNotes();
}

/**
 * search notes page
 */
class _searchNotes extends State<searchNotes> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(),
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 20.0, 0.0, 0.0),
                    child: Text(
                      'Search Notes ',
                      style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Filter By: ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
            )),
            Row(
              children: <Widget>[
                myChips("Recently Opened"),
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
          ],
        ));
  }
}
