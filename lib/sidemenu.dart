import 'package:flutter/material.dart';

final Color backgroundColor = Color(0xFFFFFF);

class SideMenu extends StatefulWidget {
  @override
  sideMenu createState() => sideMenu();
}

class sideMenu extends State<SideMenu> {

  bool isCollapsed = true; //collapsing menu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  /**
   * grid view homepage layout
   */
  Widget menu(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36.0),
      child: Align(
        alignment: Alignment.centerLeft, //moving the sidemenu
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("My Account",
                style: TextStyle(color: Colors.black, fontSize: 22.0)),
            SizedBox(height: 10.0),
            Text("",
                style: TextStyle(color: Colors.black, fontSize: 22.0)),
            SizedBox(height: 10.0),
            Text("Upload",
                style: TextStyle(color: Colors.black, fontSize: 22.0)),
            SizedBox(height: 10.0),
            Text("Get Help",
                style: TextStyle(color: Colors.black, fontSize: 22.0)),
            SizedBox(height: 10.0),
            Text("Upgrade Account",
                style: TextStyle(color: Colors.black, fontSize: 22.0)),
            SizedBox(height: 10.0),
            Text("Trash",
                style: TextStyle(color: Colors.black, fontSize: 22.0)),
            SizedBox(height: 10.0),
            Text("Settings",
                style: TextStyle(color: Colors.black, fontSize: 22.0)),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  /**
   * notescout slideout menu here
   */
  Widget dashboard(context){
    return Material(
      elevation: 8.0,
      color: backgroundColor,
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 48.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(Icons.menu, color: Colors.blue),
                Text("NoteScout", style: TextStyle(fontSize: 24.0, color: Colors.blue)),
                Icon(Icons.settings, color: Colors.blue),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
