import 'package:flutter/material.dart';

class EditNote extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: EditNotePage(),
    );
  }
}

class EditNotePage extends StatefulWidget {
  EditNotePage({Key key}): super(key: key);

  @override
  EditNotePageState createState() => EditNotePageState();
}

class EditNotePageState extends State<EditNotePage> {
  String text = "";

  FocusNode focus;

  final text_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    focus = FocusNode();
    // node.addListener(handle_focus_change); FIXME
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
      ),
      body: EditableText(controller: text_controller, focusNode: focus,
                         style: DefaultTextStyle.of(context).style,
                         cursorColor: Color.fromARGB(255, 0, 0, 0),
                         backgroundCursorColor: Color.fromARGB(0, 0, 0, 0)),
    );
  }
}
