import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  InfoPage({Key key}) : super(key: key);

  @override
  InfoPageState createState() => new InfoPageState();
}

class InfoPageState extends State<InfoPage> {
  // Loading folder list callback.  After last post, returns null.
  Widget loadFolder(BuildContext context, int index) {
    int views = 10000;
    int recent_views = 1000;

    int bookmarks = 1000;
    int recent_bookmarks = 100;
    double rating = 3.5;

    switch (index) {
      case 0:
        return Container(
          height: 50,
          color: Colors.transparent,
          child: Text('Average Rating: ${rating}'),
        );
      case 1:
        return Container(
          height: 50,
          color: Colors.transparent,
          child: Text('All Time Views: ${views}'),
        );
      case 2:
        return Container(
          height: 50,
          color: Colors.transparent,
          child: Text('Recent Views: ${recent_views}'),
        );
      case 3:
        return Container(
          height: 50,
          color: Colors.transparent,
          child: Text('All Time Bookmarks: ${bookmarks}'),
        );
      case 4:
        return Container(
          height: 50,
          color: Colors.transparent,
          child: Text('Recent Bookmarks: ${recent_bookmarks}'),
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Note Info / Analytics")),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: loadFolder,
      ),
    );
  }
}
