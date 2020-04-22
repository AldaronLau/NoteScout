import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon_data.dart';

import 'package:note_scout/edit.dart';

class ViewNotePage extends StatefulWidget {
    ViewNotePage({Key key}): super(key: key);

    @override
    ViewNotePageState createState() => new ViewNotePageState();
}

class ViewNotePageState extends State<ViewNotePage> {
    int rating = 0;
    double community_rating = 3.5;
    String notification = null;

    @override
    void initState() {
        super.initState();
        notification = null;
    }

    @override
    Widget build(BuildContext context) {
        List<Widget> bottom = [];
        if (notification != null) {
            bottom.add(Text(notification));
        }
        bottom.add(Container(color: Theme.of(context).primaryColor, child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [FlatButton(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "Rate This Note",
                    style: TextStyle(fontSize: 18.0),
                ),
                onPressed: () {
                    setState(() { notification = null; });
                    showDialog(
                        context: context,
                        builder: (_) {
                            return MyDialog(state: this);
                        },
                    );
                },
            ),
            IconButton(
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
            ),
        ])));

        return Scaffold(
            appBar: AppBar(
                title: Text("View Note"),
            ),
            body: Container(
                child: Image.network("http://images.freeimages.com/images/previews/bf6/note-paper-1155539.jpg"),
            ),
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
                                Navigator.of(context).pop();
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
                                Navigator.of(context).pop();
                            },
                            child: Text("Update Rating"),
                        ),
                    ]
                ),
            ],
        );
    }
}
