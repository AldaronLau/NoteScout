import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';

import 'package:note_scout/edit.dart';
import 'package:note_scout/info.dart';
import 'package:note_scout/selectfolder.dart';


enum ViewNoteMode {
    // For notes not owned by the user
    Browsing,
    // For notes owned by the user.
    Owned,
}

class ViewNotePage extends StatefulWidget {
    ViewNoteMode mode;
    bool bookmarked;
    final String value;
    ViewNotePage({Key key, this.mode, this.bookmarked = false, this.value}): super(key: key);

    @override
    ViewNotePageState createState() => new ViewNotePageState();
}

class ViewNotePageState extends State<ViewNotePage> {

    bool bookmarked = false;
    int rating = 0;
    double community_rating = 3.5;
    String notification = null;

    @override
    void initState() {
        super.initState();
        assert(widget.mode != null);
        notification = null;
        if (widget.bookmarked) {
            bookmarked = true;
        }
    }

    @override
    Widget build(BuildContext context) {
        List<Widget> bottom = [];
        List<Widget> left = [];
        List<Widget> right = [];
        if (notification != null) {
            bottom.add(Text(notification));
        }
        if (widget.mode == ViewNoteMode.Owned) {
            // Edit your notes
            right.add(IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                    notification = null;
                    // Switch to edit screen
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                            return EditNotePage();
                        }),
                    );
                },
            ));
        } else {
            // Rate other people's notes
            left.add(FlatButton(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "Rate This Note",
                    style: TextStyle(fontSize: 18.0),
                ),
                onPressed: () async {
                    setState(() {
                        notification = null;
                    });
                    await showDialog(
                        context: context,
                        builder: (_) {
                            return MyDialog(state: this);
                        },
                    );
                    setState(() {
                        if(notification == null) {
                            notification = "Did Not Modify Rating";
                        }
                    });
                },
            ));
            IconData bookmark_icon;
            if (bookmarked) {
                bookmark_icon = Icons.bookmark;
            } else {
                bookmark_icon = Icons.bookmark_border;
            }
            // Bookmark other people's notes
            right.add(IconButton(
                icon: Icon(bookmark_icon),
                onPressed: () {
                    setState(() {
                        bookmarked = !bookmarked;
                        if(bookmarked) {
                            notification = "Bookmarked this note";
                        } else {
                            notification = "Removed bookmark";
                        }
                    });
                }
            ));
        }

        bottom.add(Container(color: Theme.of(context).primaryColor, child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Row(children: left), Row(children: right)]
        )));

        List<String> menu_options = [];

        menu_options.add("Note Info");
        menu_options.add("Move Note...");
        menu_options.add("Copy Note...");
        menu_options.add("Tags...");
        if (widget.mode == ViewNoteMode.Owned) {
            menu_options.add("Rename Note");
            menu_options.add("Delete Note");
        }

        return Scaffold(
            appBar: AppBar(
                title: Text("View Note"),
                actions: <Widget>[
                    PopupMenuButton<String>(
                        onSelected: (String choice) {
                            switch (choice) {
                                case "Delete Note":
                                    showDialog(
                                        context: context,
                                        builder: (_) => DeleteNote(),
                                    );
                                    break;
                                case "Rename Note":
                                    showDialog(
                                        context: context,
                                        builder: (_) => RenameNote(),
                                    );
                                    break;
                                case "Move Note...":
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                            return SelectFolder(mode: FolderMode.Move);
                                        }),
                                    );
                                    break;
                                case "Copy Note...":
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                            return SelectFolder(mode: FolderMode.Copy);
                                        }),
                                    );
                                    break;
                                case "Tags...":
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                            return SelectFolder(mode: FolderMode.Labels);
                                        }),
                                    );
                                    break;
                                case "Note Info":
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                            return InfoPage();
                                        }),
                                    );
                                    break;
                                default:
                                    break;
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
            body: //Container(
                new Text("${widget.value}"),
                //child: Image.network("http://images.freeimages.com/images/previews/bf6/note-paper-1155539.jpg"),
                //Text(controller.text)

            //),
            bottomNavigationBar: BottomAppBar(
                color: Color.fromARGB(0xFF, 0xDE, 0xE9, 0xA9),
                child: Column(mainAxisSize: MainAxisSize.min, children: bottom),
            ),
        );
    }

    void notify(String text) {
        setState(() { notification = text; });
    }
}

class MyDialog extends StatefulWidget {
    ViewNotePageState state;

    MyDialog({Key key, this.state}): super(key: key);

    @override
    MyDialogState createState() { return new MyDialogState(); }
}

class MyDialogState extends State<MyDialog> {
    int new_rating;

    @override
    void initState(){
        super.initState();
        new_rating = widget.state.rating;
    }

    IconData icon_for_rating(int star_num) {
        if(new_rating == 0) {
            double f = star_num - widget.state.community_rating;
            if (f >= 0.75) {
                return Icons.star_border;
            } else if(f >= 0.25) {
                return Icons.star_half;
            } else {
                return Icons.star;
            }
        } else if(new_rating < star_num) {
            return Icons.star_border;
        } else {
            return Icons.star;
        }
    }

    Color rating_color() {
        if(new_rating == 0) {
            return Color.fromARGB(0xFF, 0xCC, 0xCC, 0xCC);
        } else {
            return Color.fromARGB(0xFF, 0xBB, 0xBB, 0);
        }
    }

    void rate(BuildContext context, int new_rating) {
        this.new_rating = new_rating;
    }

    @override
    Widget build(BuildContext context) {
        return new AlertDialog(
            title: const Text('Rate This Note'),
            content: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Text("How useful is this note?"),
                ],
            ),
            actions: <Widget>[
                new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        IconButton(
                            color: rating_color(),
                            icon: Icon(icon_for_rating(1)),
                            tooltip: 'Give 1 Star Rating',
                            onPressed: () {
                                setState(() { rate(context, 1); });
                            },
                        ),
                        IconButton(
                            color: rating_color(),
                            icon: Icon(icon_for_rating(2)),
                            tooltip: 'Give 2 Star Rating',
                            onPressed: () {
                                setState(() { rate(context, 2); });
                            },
                        ),
                        IconButton(
                            color: rating_color(),
                            icon: Icon(icon_for_rating(3)),
                            tooltip: 'Give 3 Star Rating',
                            onPressed: () {
                                setState(() { rate(context, 3); });
                            },
                        ),
                        IconButton(
                            color: rating_color(),
                            icon: Icon(icon_for_rating(4)),
                            tooltip: 'Give 4 Star Rating',
                            onPressed: () {
                                setState(() { rate(context, 4); });
                            },
                        ),
                        IconButton(
                            color: rating_color(),
                            icon: Icon(icon_for_rating(5)),
                            tooltip: 'Give 5 Star Rating',
                            onPressed: () {
                                setState(() { rate(context, 5); });
                            },
                        ),
                    ]
                ),
                new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        FlatButton(
                            onPressed: () {
                                setState(() { rate(context, 0); });
                                widget.state.notify("Removed Rating");
                                widget.state.rating = new_rating;
                                Navigator.of(context).pop(false);
                            },
                            child: Text("Remove Rating"),
                        ),
                        FlatButton(
                            onPressed: () {
                                if(new_rating == 0) {
                                    widget.state.notify("Did Not Rate Note");
                                } else if(new_rating == widget.state.rating) {
                                    widget.state.notify("Kept Same Rating");
                                } else if (widget.state.rating == 0) {
                                    widget.state.notify("Added Rating");
                                } else {
                                    widget.state.notify("Updated Rating");
                                }
                                widget.state.rating = new_rating;
                                Navigator.of(context).pop(false);
                            },
                            child: Text("Update Rating"),
                        ),
                    ]
                ),
            ],
        );
    }
}

class DeleteNote extends StatefulWidget {
    DeleteNote({Key key}): super(key: key);

    @override
    DeleteNoteState createState() { return new DeleteNoteState(); }
}

class DeleteNoteState extends State<DeleteNote> {
    @override
    Widget build(BuildContext context) {
        return new AlertDialog(
            title: const Text('Delete This Note?'),
            actions: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        FlatButton(
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                        ),
                        FlatButton(
                            onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                            },
                            child: Text("Delete"),
                        ),
                    ]
                ),
            ],
        );
    }
}

class RenameNote extends StatefulWidget {
    RenameNote({Key key}): super(key: key);

    @override
    RenameNoteState createState() { return new RenameNoteState(); }
}

class RenameNoteState extends State<RenameNote> {
    TextEditingController text_controller;

    @override
    void initState() {
        super.initState();
        text_controller = TextEditingController(
            text: "Untitled Note",
        );
    }

    @override
    Widget build(BuildContext context) {
        return new AlertDialog(
            title: const Text('Rename Note'),
            content: TextField(controller: text_controller,
                toolbarOptions: ToolbarOptions(
                    copy: false, cut: false, paste: false, selectAll: false
                ),
                autofocus: true),
            actions: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        FlatButton(
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                        ),
                        FlatButton(
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                            child: Text("Rename"),
                        ),
                    ]
                ),
            ],
        );
    }
}
