import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:note_scout/main.dart';

// FAQ answers page
class Faq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frequently Asked Questions"),
        centerTitle: true,
        backgroundColor: APPCOLOR,
      ),
      body: Stack(children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: Text("Questions: How do I upload a note? \n\n"
                "Answers: Open the camera button and take a picture of the note, to upload it to the screen. If you have the note aready in your canera roll sellect gallery \n\n"
                "Question: How do I view my notes? \n\n"
                "Answer: View notes by going to the view menu and click view, to see all the notes you have \n\n"
                "Questions: How do I search my notes? \n\n"
                "Answer: Use the search bar to look at all notes that have been uploaded\n\n"
                "Question: How do I find my bookmarked notes? \n\n"
                "Answer: Press the bookmark to see any notes that you found interesting and have saved\n\n"
                "If you have any more questions contact us at\n\n"
                "Olderrm@augsburg.edu, Mengl@augsburg.edu, Leek7@augsburg.edu or at Lauj@augsburg.edu\n\n ")),
      ]),
    );
  }
}
