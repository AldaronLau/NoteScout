import 'package:flutter/material.dart';

import 'package:note_scout/upload.dart';
import 'package:note_scout/trash.dart';

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
   * grid view homepage layout
   */
  Widget menu(context) {
    return Column(
        children: <Widget>[
            ListTile(
                title: const Text("My Account", style: TextStyle(color: Colors.black, fontSize: 22.0)),
                onTap: () {
                    print("TODO");
                }
            ),
            ListTile(
                title: const Text("Upload", style: TextStyle(color: Colors.black, fontSize: 22.0)),
                onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                            return upload();
                        }),
                    );
                }
            ),
            ListTile(
                title: const Text("Get Help", style: TextStyle(color: Colors.black, fontSize: 22.0)),
                onTap: () {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => new stopitGetHelp()
                        ));
                }
            ),
            ListTile(
                title: const Text("Upgrade Account", style: TextStyle(color: Colors.black, fontSize: 22.0)),
                onTap: () {
                    print("TODO");
                }
            ),
            ListTile(
                title: const Text("Trash", style: TextStyle(color: Colors.black, fontSize: 22.0)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return trash();
                    }),
                  );
                }
            ),
            ListTile(
                title: const Text("Settings", style: TextStyle(color: Colors.black, fontSize: 22.0)),
                onTap: () {
                    print("TODO");
                }
            ),
          ],
        );
  }

  /**
   * notescout slideout menu here
   */
  Widget dashboard(context){
    return Material(
      color: backgroundColor,
      child: DrawerHeader(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Text("NoteScout", style: TextStyle(fontSize: 36.0)),
              Icon(Icons.settings, color: Colors.black),
          ],
      )),
    );
  }
}
