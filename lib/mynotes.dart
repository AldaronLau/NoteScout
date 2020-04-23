import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';

import 'package:note_scout/view.dart';
import 'package:note_scout/edit.dart';
import 'package:note_scout/upload.dart';

enum MyNotesMode {
    // For notes not owned by the user
    Browsing,
    // For notes owned by the user.
    Owned,
}

class MyNotesPage extends StatefulWidget {
    MyNotesMode mode;

    MyNotesPage({Key key, this.mode}): super(key: key);

    @override
    MyNotesPageState createState() => new MyNotesPageState();
}

class MyNotesPageState extends State<MyNotesPage> {

    bool foldersInsteadOfTags = true;
    int rating = 0;
    double community_rating = 3.5;
    String notification = null;

    // Loading folder list callback.  After last post, returns null.
    Widget loadFolder(BuildContext context, int index) {
        if (index >= 24) {
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
                        return FolderPage(mode: widget.mode);
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
    void initState() {
        super.initState();
        assert(widget.mode != null);
        notification = null;
    }

    @override
    Widget build(BuildContext context) {
        List<String> menu_options = ["Sort By Tag", "Sort By Folder"];

        String title;

        if (widget.mode == MyNotesMode.Owned) {
            title = "My Notes";
            menu_options.add("New Note");
            menu_options.add("Upload Note");
        } else {
            title = "Bookmarks";
        }

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
                                case "New Note":
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                            return ViewNotePage(mode: ViewNoteMode.Owned);
                                        }),
                                    );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                            return EditNotePage();
                                        }),
                                    );
                                    break;
                                case "Upload Note":
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                            return upload();
                                        }),
                                    );
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

class FolderPage extends StatefulWidget {
    MyNotesMode mode;

    FolderPage({Key key, this.mode}): super(key: key);

    @override
    FolderPageState createState() => new FolderPageState();
}

class FolderPageState extends State<FolderPage> {

    bool foldersInsteadOfTags = true;
    int rating = 0;
    double community_rating = 3.5;
    String notification = null;

    // Loading folder list callback.  After last post, returns null.
    Widget loadFolder(BuildContext context, int index) {
        if (index >= 24) {
            return null;
        }

        String name = " Note #";

        IconData icon = Icons.note;

        return GestureDetector(
            onTap: () {
                ViewNoteMode mode;
                bool bookmarked;
                if (widget.mode == MyNotesMode.Owned) {
                    mode = ViewNoteMode.Owned;
                    bookmarked = false;
                } else {
                    mode = ViewNoteMode.Browsing;
                    bookmarked = true;
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                        return ViewNotePage(mode: mode, bookmarked: bookmarked);
                    }),
                );
            },
            child: Column(children: [Container(
                height: 50,
                color: Colors.transparent,
                child: Row(children: [
                    Icon(icon),
                    Text('${name} ${index + 1}'),
                ]),
            ), Divider()]),
        );
    }

    @override
    void initState() {
        super.initState();
        assert(widget.mode != null);
        notification = null;
    }

    @override
    Widget build(BuildContext context) {
        List<String> menu_options = ["Sort By Tag", "Sort By Folder"];

        String title;
        List<Widget> actions = [];

        if (widget.mode == MyNotesMode.Owned) {
            title = "My Notes";
            menu_options.add("New Note");
            menu_options.add("Upload Note");

            actions.add(IconButton(
                onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                            return ViewNotePage(mode: ViewNoteMode.Owned);
                        }),
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                            return EditNotePage();
                        }),
                    );
                },
                icon: Icon(Icons.note_add),
            ));
            actions.add(IconButton(
                onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                            return upload();
                        }),
                    );
                },
                icon: Icon(Icons.file_upload),
            ));
        } else {
            title = "Bookmarks";
        }

        return Scaffold(
            appBar: AppBar(
                title: Text(title),
                actions: actions,
            ),
            body: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: loadFolder,
            ),
        );
    }
}
