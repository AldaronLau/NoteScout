import 'package:flutter/material.dart';

import 'package:note_scout/uploader.dart';
import 'package:note_scout/trash.dart';
import 'package:note_scout/faq.dart';
import 'package:note_scout/settings.dart';
import 'package:note_scout/permission.dart';

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
      body: ListView(
        children: <Widget>[
          dashboard(context),
          menu(context),
        ],
      ),
    );
  }

  /**
   * Sidebar menu layout.
   */
  Widget menu(context) {
    return Column(
      children: <Widget>[
        ListTile(
            title: const Text("My Account",
                style: TextStyle(color: Colors.black, fontSize: 22.0)),
            onTap: () {
              print("TODO");
            }),
        ListTile(
            title: const Text("Upload",
                style: TextStyle(color: Colors.black, fontSize: 22.0)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return UplUD();
                }),
              );
            }),
        ListTile(
            title: const Text("Get Help",
                style: TextStyle(color: Colors.black, fontSize: 22.0)),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new Faq()));
            }),
        ListTile(
            title: const Text("Upgrade Account",
                style: TextStyle(color: Colors.black, fontSize: 22.0)),
            onTap: () {
              print("TODO");
            }),
        ListTile(
            title: const Text("Trash",
                style: TextStyle(color: Colors.black, fontSize: 22.0)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return TrashPage();
                }),
              );
            }),
        ListTile(
            title: const Text("Settings",
                style: TextStyle(color: Colors.black, fontSize: 22.0)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Perpart();
                }),
              );
            }),
      ],
    );
  }

  /**
   * notescout slideout menu here
   */
  Widget dashboard(context) {
    return Material(
      color: backgroundColor,
      child: DrawerHeader(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("NoteScout", style: TextStyle(fontSize: 36.0)),
        ],
      )),
    );
  }
}
