import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TrashPage extends StatefulWidget {
  @override
  TrashPageState createState() => new TrashPageState();
}

class TrashPageState extends State<TrashPage> {
  bool foldersInsteadOfTags = true;
  int rating = 0;
  double community_rating = 3.5;
  String notification = null;

  // Loading folder list callback.  After last post, returns null.
  Widget loadFolder(BuildContext context, int index) {
    if (index >= 6) {
      return null;
    }

    String name;

    if (foldersInsteadOfTags) {
      name = " Folder #";
    } else {
      name = " Tag #";
    }

    IconData icon;

    if (foldersInsteadOfTags) {
      icon = Icons.folder;
    } else {
      icon = Icons.label;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return trash();

          }),
        );
      },
      child: Column(children: [
        Container(
          height: 50,
          color: Colors.transparent,
          child: Row(children: [
            Icon(icon),
            Text('${name}${index + 1}'),
          ]),
        ),
        Divider()
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> menu_options = ["Sort By Tag", "Sort By Folder", "Trash Policy"];

    String title;

    title = "Trash";

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          PopupMenuButton<String>(onSelected: (String choice) {
            switch (choice) {
              case "Sort By Tag":
                setState(() {
                  foldersInsteadOfTags = false;
                });
                break;
              case "Sort By Folder":
                setState(() {
                  foldersInsteadOfTags = true;
                });
                break;
              case "Trash Policy":
                showDialog(context: context,
                builder: (BuildContext context) => _buildAboutDialog(context),
                );
                break;
              default:
                assert(false);
            }
          }, itemBuilder: (BuildContext context) {
            return menu_options.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          }),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: loadFolder,
      ),
    );
  }
}


Widget _buildAboutDialog(BuildContext context){
  return new AlertDialog(
    title: const Text('Trash Policy'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildAboutText(),
        //_buildLogoAttribution(),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Okay, got it!'),
      ),
    ],
  );
}

Widget _buildAboutText() {
  return new RichText(
    text: new TextSpan(
      text: 'This is the Trash Policy, Whatever notes you delete from your NoteScout account will be put in this trash location. You are able to recover it within 10 days. '
          'Else after 10 days it will be deleted permanently.\n\n',
      style: const TextStyle(color: Colors.black87),
    ),
  );
}

//This is in case we want to add logo attribution to the Policy pop-up
/*
Widget _buildLogoAttribution() {
  return new Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: new Row(
      children: <Widget>[
      /*  new Padding(
         padding: const EdgeInsets.only(top: 0.0),
          child: new Image.asset(
            "assets/flutter.png",
            width: 32.0,
          ),
        ),
        */
        const Expanded(
          child: const Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: const Text(
              'Make sure to recover the notes you need before 10 days!!',
              style: const TextStyle(fontSize: 12.0),
            ),
          ),
        ),
      ],
    ),
  );
}
*/

class trash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Trash"),
        centerTitle: true,
      ),
      body: Stack(children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: Text("This is the trash for your unwanted notes")),
      ]),
    );
  }
}
