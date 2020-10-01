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
      child: Column(children: [Container(
        height: 50,
        color: Colors.transparent,
        child: Row(children: [
          Icon(icon),
          Text('${name}${index + 1}'),
        ]),
      ), Divider()]),
    );
  }


  @override
  Widget build(BuildContext context) {
    List<String> menu_options = ["Sort By Tag", "Sort By Folder"];

    String title;

    title = "Trash";


    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: (String choice) {
                switch (choice) {
                  case "Sort By Tag":
                    setState(() { foldersInsteadOfTags = false; });
                    break;
                  case "Sort By Folder":
                    setState(() { foldersInsteadOfTags = true; });
                    break;

                  default:
                    assert(false);
                }
              },
              itemBuilder: (BuildContext context) {
                return menu_options.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              }
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: loadFolder,
      ),
    );
  }
}



class trash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trash"),
        centerTitle: true,
      ),
      body: Stack(
          children: <Widget>[

            Align(
                alignment: Alignment.center,
                child: Text("This is the trash for your unwanted notes"
                )
            ),


          ]
      ),
    );
  }


}





